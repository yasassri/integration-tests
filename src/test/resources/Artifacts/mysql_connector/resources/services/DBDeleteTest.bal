package resources.services;

import ballerina.data.sql;
import resources.connectorInit as conn;

sql:ClientConnector connInitD = conn:init();

function deleteWithParams (string query, string valueToBeDeleted) (int, error){

    endpoint<sql:ClientConnector> ep{

    }
    bind connInitD with ep;
    sql:Parameter[] parameters = [];
    error err;
    int noOfRows;

    try {
        sql:Parameter para = {sqlType:sql:Type.VARCHAR, value:valueToBeDeleted, direction:sql:Direction.IN};
        parameters = [para];
        noOfRows = ep.update(query, parameters);
    } catch (error e) {
        err = e;
    }
    return noOfRows, err;
}

function deleteGeneral (string query) (int, error){

    endpoint<sql:ClientConnector> ep{

    }
    bind connInitD with ep;
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