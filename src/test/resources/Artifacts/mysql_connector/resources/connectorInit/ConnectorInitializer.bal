package resources.connectorInit;

import ballerina.data.sql;
import ballerina.lang.system;


function init () (sql:ClientConnector connection){
    string mysqlHostName = system:getEnv("MYSQL_HOSTNAME");
    var mysqlPort, _ = <int>system:getEnv("MYSQL_PORT");
    string mysqlDatabase = system:getEnv("MYSQL_DATABASE");
    string mysqlUserName = system:getEnv("MYSQL_USER");
    string mysqlPassword = system:getEnv("MYSQL_PASSWORD");

    sql:ConnectionProperties properties = {maximumPoolSize:2, connectionTimeout:300000};
    connection = create sql:ClientConnector(
                                 sql:MYSQL, mysqlHostName, mysqlPort, mysqlDatabase, mysqlUserName, mysqlPassword, properties);
    return;
}

function initOther () (sql:ClientConnector connectionOther){
    string mysqlHostNameOther = system:getEnv("MYSQL_OTHER_HOSTNAME");
    var mysqlPortOther, _ = <int>system:getEnv("MYSQL_OTHER_PORT");
    string mysqlDatabaseOther = system:getEnv("MYSQL_OTHER_DATABASE");
    string mysqlUserNameOther = system:getEnv("MYSQL_OTHER_USER");
    string mysqlPasswordOther = system:getEnv("MYSQL_OTHER_PASSWORD");

    sql:ConnectionProperties properties = {maximumPoolSize:3, connectionTimeout:300000};
    connectionOther = create sql:ClientConnector(
                                 sql:MYSQL, mysqlHostNameOther, mysqlPortOther, mysqlDatabaseOther, mysqlUserNameOther, mysqlPasswordOther, properties);
    return;
}
