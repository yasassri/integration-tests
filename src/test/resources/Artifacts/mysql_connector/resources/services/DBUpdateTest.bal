package resources.services;

import ballerina.data.sql;
import resources.connectorInit as conn;

sql:ClientConnector connInitU = conn:init();

function updateWithParams (string query, string value1, float value2) (int, error){

    endpoint<sql:ClientConnector> ep{

    }
    bind connInitU with ep;
    sql:Parameter[] parameters = [];
    error err;
    int noOfRows;

    try {
        sql:Parameter para1 = {sqlType:sql:Type.VARCHAR, value:value1, direction:sql:Direction.IN};
        sql:Parameter para2 = {sqlType:sql:Type.DOUBLE, value:value2, direction:sql:Direction.IN};
        parameters = [para1, para2];
        noOfRows = ep.update (query, parameters);
    } catch (error e) {
        string msg = "Error in database update. Please retry";
        err = {msg:msg};
    }
    return noOfRows, err;
}

function updateWithMissingParams (string query, string value1, float value2) (int, error){

    endpoint<sql:ClientConnector> ep{

    }
    bind connInitU with ep;
    sql:Parameter[] parameters = [];
    error err;
    int noOfRows;

    try {
        sql:Parameter para1 = {sqlType:sql:Type.VARCHAR, value:value1, direction:sql:Direction.IN};
        parameters = [para1];
        noOfRows = ep.update (query, parameters);
    } catch (error e) {
        string msg = "Error in database update. Please retry";
        err = {msg:msg};
    }
    return noOfRows, err;
}

function updateWithoutParams (string query) (int, error){

    endpoint<sql:ClientConnector> ep{

    }
    bind connInitU with ep;
    sql:Parameter[] parameters = [];
    error err;
    int noOfRows;

    try {
        noOfRows = ep.update (query, parameters);
    } catch (error e) {
        err = e;
    }
    return noOfRows, err;
}