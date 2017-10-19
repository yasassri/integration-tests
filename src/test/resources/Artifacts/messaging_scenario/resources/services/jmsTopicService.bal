import ballerina.net.jms;
import ballerina.lang.messages;
import ballerina.lang.system;
import org.wso2.ballerina.connectors.twitter;
import ballerina.lang.jsons;
import org.wso2.ballerina.connectors.facebook;

@jms:configuration {
    initialContextFactory:"org.apache.activemq.jndi.ActiveMQInitialContextFactory",
    providerUrl:"tcp://localhost:61616",
    connectionFactoryType:"topic",
    connectionFactoryName:"TopicConnectionFactory",
    destination:"ClassicCars"
}

service<jms> jmsClassicCarsService {

    resource onMessage (message m) {
        //Process the message
        string msgType = messages:getProperty(m, "JMS_MESSAGE_TYPE");

        if (msgType == "TextMessage") {
            string payload = messages:getStringPayload(m);
            system:println(payload);

            var count, conversionErr = <int>payload;
            if (conversionErr != null) {
                system:println("error: " + conversionErr.msg);
            } else {    //should use proper error handling here
                if (count != 0 && count % 5 == 0) {
                    var strCount = <string>count;
                    tweet(strCount);
                    postToFb(strCount);
                }
            }
        } else {
            system:println("Received message of unsupported type: " + msgType + ". Dropping the message.");
        }
    }
}

function tweet (string count) (boolean) {
    system:println("Classic Cars count is : " + count + ". Tweeting...");
    twitter:ClientConnector twitterConnector =
    create twitter:ClientConnector("wWECoh9x9tPKEwYu1kJ2FODfW",
                                   "xNdXWz1AaALjbqjwcXiYfIsK2UG8flJ0GcxCUAcJR9FiwERb4R",
                                   "918497224799260677-Q4azW5wGAc0rbVccVLmJY5TeCMflr8u",
                                   "eOVIPejeX3LAI5ZOVUlbGt4MncQ0t6Dfa2W6bgCFdr8S8");
    //<consumerKey> <consumerSecret> <accessToken> <accessTokenSecret>
    message tweetResponse = twitterConnector.tweet("Classic Cars sales hit " + count + " mark!!");
    json tweetJSONResponse = messages:getJsonPayload(tweetResponse);
    system:println(jsons:toString(tweetJSONResponse));
    return true;
}

function postToFb (string count) (boolean) {
    system:println("Classic Cars count is : " + count + ". Posting to FB...");
    facebook:ClientConnector facebookConnector = create facebook:ClientConnector("EAACEdEose0cBAKFNEHE5ExHjyjZBBrzUZCXSXhquZAkTtWgZCYZC2H3BNqfu0qpzpBhzzXdZAEcL9rfZCyoZCI0dZCIHyq0emZChDscG6ZAro2A19ZA0aCrZC6ExPuvZCy90Ai6i0iN5XCXV5652iZAOuphsU11B4O45y8bZAm1501b4Y6rxOZChQZAxWUxqhkaDwEU82CWlZCOOyqJgYkJ3xkv0A5H7DJa");
    facebookConnector.createPost("119613982128384", "Classic Cars sales hit " + count + " mark!!", "https://developers.facebook.com/docs/pages/publishing", "wso2, colombo");
    //<id> <message> <link> <place>
    return true;
}