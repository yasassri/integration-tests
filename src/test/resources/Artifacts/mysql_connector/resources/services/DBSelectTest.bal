package resources.services;

import ballerina.data.sql;
import resources.connectorInit as conn;

struct ResultCount{
    int COUNTTENPERCENT;
}

sql:ClientConnector connInit = conn:init();

function selectGeneral (string query) (json, error){

    endpoint<sql:ClientConnector> ep{

    }
    bind connInit with ep;
    sql:Parameter[] parameters = [];
    error err;
    json data = "e";

    try {
        datatable dt = ep.select (query, parameters);
        data, _ = <json>dt;
    } catch (error e) {
        err = e;
    }
    return data, err;
}

function selectBetween (string query) (json, error){

    endpoint<sql:ClientConnector> ep{

    }
    bind connInit with ep;
    sql:Parameter[] parameters = [];
    error err;
    json data;

    try {
        sql:Parameter para1 = {sqlType:sql:Type.DOUBLE, value:5500.50, direction:sql:Direction.IN};
        sql:Parameter para2 = {sqlType:sql:Type.DOUBLE, value:11350.50, direction:sql:Direction.IN};
        parameters = [para1, para2];
        datatable dt = ep.select (query, parameters);
        data, _ = <json>dt;
    } catch (error e) {
        err = e;
    }
    return data, err;
}

function selectLike (string query) (json, error){

    endpoint<sql:ClientConnector> ep{

    }
    bind connInit with ep;
    sql:Parameter[] parameters = [];
    error err;
    json data;
    string value = "or";
    string likeValue = string `%{{value}}%`;

    try {
        sql:Parameter para = {sqlType:sql:Type.VARCHAR, value:likeValue, direction:sql:Direction.IN};
        parameters = [para];
        datatable dt = ep.select (query, parameters);
        data, _ = <json>dt;
    } catch (error e) {
        err = e;
    }
    return data, err;
}

function selectIn (string query) (json, error){


    endpoint<sql:ClientConnector> ep{

    }
    bind connInit with ep;
    sql:Parameter[] parameters = [];
    error err;
    json data;
    string [] in = ["Germany", "UK"];
    try {
        sql:Parameter para = {sqlType:sql:Type.VARCHAR, value:in, direction:sql:Direction.IN};
        parameters = [para];
        datatable dt = ep.select (query, parameters);
        data, _ = <json>dt;
    } catch (error e) {
        err = e;
    }
    return data, err;
}

function selectAndOr (string query) (json, error){


    endpoint<sql:ClientConnector> ep{

    }
    bind connInit with ep;
    sql:Parameter[] parameters = [];
    error err;
    json data;

    try {
        sql:Parameter para1 = {sqlType:sql:Type.VARCHAR, value:"Berlin", direction:sql:Direction.IN};
        sql:Parameter para2 = {sqlType:sql:Type.VARCHAR, value:"München", direction:sql:Direction.IN};
        sql:Parameter para3 = {sqlType:sql:Type.VARCHAR, value:"Germany", direction:sql:Direction.IN};
        parameters = [para3, para1, para2];
        datatable dt = ep.select (query, parameters);
        data, _ = <json>dt;
    } catch (error e) {
        err = e;
    }
    return data, err;
}

function selectWithLimit () (json, error){


    endpoint<sql:ClientConnector> ep{

    }
    bind connInit with ep;
    sql:Parameter[] parameters = [];
    error err;
    TypeCastError ex;
    json data;
    int count;

    try {
        datatable dt = ep.select ("select CEIL(count(CustomerID)*50/100) as countTenPercent from Customers", parameters);
        ResultCount rs;
        while (dt.hasNext()) {
            any dataStruct = dt.getNext();
            rs, ex = (ResultCount) dataStruct;
            count = rs.COUNTTENPERCENT;
        }
        sql:Parameter para = {sqlType:sql:Type.INTEGER, value:count, direction:sql:Direction.IN};
        parameters = [para];
        dt = ep.select ("select CustomerName from Customers ORDER BY TotalPurchases DESC limit 4", parameters);
        data, _ = <json>dt;
    } catch (error e) {
        err = e;
    }
    return data, err;
}

function selectWithExists (string query) (json, error){


    endpoint<sql:ClientConnector> ep{

    }
    bind connInit with ep;
    sql:Parameter[] parameters = [];
    error err;
    json data;

    try {
        sql:Parameter para = {sqlType:sql:Type.INTEGER, value:20, direction:sql:Direction.IN};
        parameters = [para];
        datatable dt = ep.select (query, parameters);
        data, _ = <json>dt;
    } catch (error e) {
        err = e;
    }
    return data, err;
}

function selectWithComplexSql () (json, error){


    endpoint<sql:ClientConnector> ep{

    }
    bind connInit with ep;
    sql:Parameter[] parameters = [];
    error err;
    json data;

    try {
        sql:Parameter para1 = {sqlType:sql:Type.INTEGER, value:3, direction:sql:Direction.IN};
        sql:Parameter para2 = {sqlType:sql:Type.INTEGER, value:0, direction:sql:Direction.IN};
        parameters = [para1, para2];
        datatable dt = ep.select ("select Country, TRUNCATE(MAX(LoyaltyPoints/TotalPurchases), ?) as MaxBuyingRatio from Customers where TotalPurchases > ? group by Country", parameters);
        data, _ = <json>dt;
    } catch (error e) {
        err = e;
    }
    return data, err;
}

function selectGeneralToXml (string query) (xml, error){


    endpoint<sql:ClientConnector> ep{

    }
    bind connInit with ep;
    sql:Parameter[] parameters = [];
    error err;
    xml data;

    try {
        datatable dt = ep.select (query, parameters);
        data, _ = <xml>dt;
    } catch (error e) {
        err = e;
    }
    return data, err;
}
