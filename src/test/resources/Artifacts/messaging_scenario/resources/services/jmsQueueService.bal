import ballerina.lang.messages;
import ballerina.lang.strings;
import ballerina.lang.system;
import ballerina.net.jms;
import ballerina.data.sql;

@jms:configuration {
    initialContextFactory:"org.apache.activemq.jndi.ActiveMQInitialContextFactory",
    providerUrl:"tcp://localhost:61616",
    connectionFactoryType:"queue",
    connectionFactoryName:"QueueConnectionFactory",
    destination:"MyQueue",
    acknowledgmentMode:"AUTO_ACKNOWLEDGE"
}

service<jms> jmsQueueService {

    map countMap = {};

    resource onMessage (message m) {

        //Process the message
        string msgType = messages:getProperty(m, "JMS_MESSAGE_TYPE");

        if (msgType == "TextMessage") {

            sql:ConnectionProperties properties = {maximumPoolSize:5};
            sql:ClientConnector testDB = create sql:ClientConnector(
                                         sql:MYSQL, "localhost", 3306, "ballerina_hack", "root", "root", properties);

            string payload = messages:getStringPayload(m);
            system:println(payload);
            string[] productsArray = strings:split(payload, "\n");
            int productsArrayLength = lengthof productsArray;
            system:println(productsArrayLength);
            int i = 0;
            while (i < productsArrayLength) {
                string[] productArray = strings:split(productsArray[i], ",");
                int productArrayLength = lengthof productArray;
                if (productArrayLength != 3) {
                    system:println("Invalid line found in CSV message. Expected 3 values, but found:
                     " + productArrayLength + ". Dropping entry: " + productsArray[i]);
                    i = i + 1;
                    continue;
                }
                var price, _ = <float>productArray[2];

                //for debugging. remove later.
                system:println("Name: " + productArray[0]);
                system:println("Type: " + productArray[1]);
                system:println("Price: " + price);

                sql:Parameter[] params = [];
                sql:Parameter name = {sqlType:"varchar", value:productArray[0]};
                sql:Parameter prodType = {sqlType:"varchar", value:productArray[1]};
                sql:Parameter priceParam = {sqlType:"float", value:price};

                params = [name, prodType, priceParam];
                int ret = testDB.update("Insert into Products (name,type,price) values (?,?,?)",
                                        params);
                system:println("Inserted row count: " + ret);

                if (countMap[productArray[1]] == null) {
                    countMap[productArray[1]] = 1;
                } else {
                    var count, _ = (int)countMap[productArray[1]];
                    countMap[productArray[1]] = count + 1;
                }

                //PUSH THE COUNT TO A TOPIC
                var count, _ = (int)countMap[productArray[1]];
                var strCount = <string>count;

                boolean response = sendTextMessageToTopic((string)productArray[1], strCount);

                i = i + 1;
            }

            testDB.close();

        } else {
            system:println("Received message of unsupported type: " + msgType + ". Dropping the message.");
        }
    }
}


function sendTextMessageToTopic (string topic, string msg) (boolean) {
    map properties = {"initialContextFactory":"org.apache.activemq.jndi.ActiveMQInitialContextFactory",
                         "providerUrl":"tcp://localhost:61616",
                         "connectionFactoryName":"TopicConnectionFactory",
                         "connectionFactoryType":"topic"};

    jms:ClientConnector jmsEP = create jms:ClientConnector(properties);
    message topicMessage = {};
    messages:setStringPayload(topicMessage, msg);

    jmsEP.send(topic, topicMessage);

    return true;
}