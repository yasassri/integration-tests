/*
 *  Copyright (c) 2017, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 *  WSO2 Inc. licenses this file to you under the Apache License,
 *  Version 2.0 (the "License"); you may not use this file except
 *  in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package org.ballerinalang.tests.connectors.jms;

/**
 * Constants that are used within the test scope.
 */
public class JMSTestConstants {
    public static final String QUEUE_CONNECTION_FACTORY = "QueueConnectionFactory";
//    public static final String ACTIVEMQ_PROVIDER_URL = "vm://localhost?broker.persistent=false";
    public static final String ACTIVEMQ_PROVIDER_URL = "tcp://localhost:61616";
    public static final String QUEUE_NAME = "MyQueue";
    public static final String ACTIVEMQ_FACTORY_INITIAL = "org.apache.activemq.jndi.ActiveMQInitialContextFactory";
}
