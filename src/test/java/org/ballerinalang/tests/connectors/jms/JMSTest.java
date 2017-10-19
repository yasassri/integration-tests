package org.ballerinalang.tests.connectors.jms;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;
import org.wso2.carbon.messaging.CarbonMessage;
import org.wso2.carbon.messaging.TextCarbonMessage;
import org.wso2.carbon.messaging.exceptions.ClientConnectorException;
import org.wso2.carbon.transport.jms.sender.JMSClientConnector;
import org.wso2.carbon.transport.jms.utils.JMSConstants;

import java.util.HashMap;
import java.util.Map;
import javax.jms.JMSException;

/**
 * A test class for testing queue listening
 */
public class JMSTest {
    private CarbonMessage carbonMessage;
    private Map<String, String> properties;
    private static final Log logger = LogFactory.getLog(JMSTest.class);

    @BeforeClass(groups = "queueSending", description = "Setting up the server and carbon message to be sent")
    public void setUp() {
        carbonMessage = new TextCarbonMessage("Hello World");
        properties = new HashMap();
        properties.put(JMSConstants.DESTINATION_PARAM_NAME, JMSTestConstants.QUEUE_NAME);
        properties.put(JMSConstants.CONNECTION_FACTORY_JNDI_PARAM_NAME, JMSTestConstants.QUEUE_CONNECTION_FACTORY);
        properties.put(JMSConstants.NAMING_FACTORY_INITIAL_PARAM_NAME, JMSTestConstants.ACTIVEMQ_FACTORY_INITIAL);
        properties.put(JMSConstants.PROVIDER_URL_PARAM_NAME, JMSTestConstants.ACTIVEMQ_PROVIDER_URL);
        properties.put(JMSConstants.CONNECTION_FACTORY_TYPE_PARAM_NAME, JMSConstants.DESTINATION_TYPE_QUEUE);
        properties.put(JMSConstants.TEXT_DATA, "Hello World");
        properties.put(JMSConstants.JMS_MESSAGE_TYPE, JMSConstants.TEXT_MESSAGE_TYPE);
        properties.put(JMSConstants.CACHE_LEVEL, ((Integer) JMSConstants.CACHE_PRODUCER).toString());
    }

    @Test(groups = "queueSending", description = "Testing whether queue sending is working correctly without any " +
            "exceptions")
    public void queueListeningTestCase() throws InterruptedException, JMSException, ClientConnectorException {
        logger.info("JMS Transport Sender is sending a message to the queue " +
                JMSTestConstants.QUEUE_NAME);
        JMSClientConnector sender = new JMSClientConnector();
        sender.send(carbonMessage, null, properties);
        sender.send(carbonMessage, null, properties);
    }
}
