package resources.services;

import ballerina.data.sql;
import resources.connectorInit as conn;

struct ResultOrders{
    int customerNumber;
    string status;
    string location;
}

sql:ClientConnector connInitS = conn:init();

function createStoredProcedure(string procedure) (int, error){

    endpoint<sql:ClientConnector> ep{

    }
    bind connInitS with ep;
    sql:Parameter[] parameters = [];
    int insertedRowCount;
    error err;

    try {
        insertedRowCount = ep.update(procedure, parameters);
    } catch (error e) {
        string msg = "Error in procedure creation. Please retry";
        e = {msg:msg};
        err = e;
    }
    return insertedRowCount, err;
}

function callProcedureSuccess(int customerNo)(any, any, any, any, any, error){

    endpoint<sql:ClientConnector> ep{

    }
    bind connInitS with ep;
    sql:Parameter[] parameters = [];
    error err;
    int inc = 5;
    int count = 0;
    sql:Parameter paraCustomerNo;
    sql:Parameter paraInc;
    sql:Parameter paraCount;
    sql:Parameter paraShipped;
    sql:Parameter paraCanceled;
    sql:Parameter paraResolved;
    sql:Parameter paraDisputed;

    try {
        paraCustomerNo = {sqlType:sql:Type.INTEGER, value:customerNo, direction:sql:Direction.IN};
        paraInc = {sqlType:sql:Type.INTEGER, value:inc, direction:sql:Direction.IN};
        paraCount = {sqlType:sql:Type.INTEGER, value:count, direction:sql:Direction.INOUT};
        paraShipped = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        paraCanceled = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        paraResolved = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        paraDisputed = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        parameters = [paraCustomerNo, paraInc, paraShipped, paraCanceled, paraResolved, paraDisputed, paraCount];
        datatable dt = ep.call ("{call get_order_by_cust(?,?,?,?,?,?,?)}", parameters);
        dt.close();
    } catch (error e) {
        string msg = "Error in procedure call. Please retry";
        e = {msg:msg};
        err = e;
    }
    return paraShipped.value, paraCanceled.value, paraResolved.value, paraDisputed.value, paraCount.value, err;
}

function callProcedureWithWrongDirectionForParams(int customerNo, string status)(any, any, any, any, any, error){

    endpoint<sql:ClientConnector> ep{

    }
    bind connInitS with ep;
    sql:Parameter[] parameters = [];
    error err;
    int inc = 5;
    int count = 0;
    sql:Parameter paraCustomerNo;
    sql:Parameter paraInc;
    sql:Parameter paraCount;
    sql:Parameter paraShipped;
    sql:Parameter paraCanceled;
    sql:Parameter paraResolved;
    sql:Parameter paraDisputed;

    try {
        if (status.equalsIgnoreCase("intoout")){
            paraCustomerNo = {sqlType:sql:Type.INTEGER, value:customerNo, direction:sql:Direction.IN};
            paraInc = {sqlType:sql:Type.INTEGER, value:inc, direction:sql:Direction.OUT};
            paraCount = {sqlType:sql:Type.INTEGER, value:count, direction:sql:Direction.INOUT};
            paraShipped = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraCanceled = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraResolved = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraDisputed = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        }
        else if (status.equalsIgnoreCase("intoinout")){
            paraCustomerNo = {sqlType:sql:Type.INTEGER, value:customerNo, direction:sql:Direction.IN};
            paraInc = {sqlType:sql:Type.INTEGER, value:inc, direction:sql:Direction.INOUT};
            paraCount = {sqlType:sql:Type.INTEGER, value:count, direction:sql:Direction.INOUT};
            paraShipped = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraCanceled = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraResolved = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraDisputed = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        }
        else if (status.equalsIgnoreCase("outtoin")){
            paraCustomerNo = {sqlType:sql:Type.INTEGER, value:customerNo, direction:sql:Direction.IN};
            paraInc = {sqlType:sql:Type.INTEGER, value:inc, direction:sql:Direction.IN};
            paraCount = {sqlType:sql:Type.INTEGER, value:count, direction:sql:Direction.INOUT};
            paraShipped = {sqlType:sql:Type.INTEGER, direction:sql:Direction.IN};
            paraCanceled = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraResolved = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraDisputed = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        }
        else if (status.equalsIgnoreCase("outtoinout")){
            paraCustomerNo = {sqlType:sql:Type.INTEGER, value:customerNo, direction:sql:Direction.IN};
            paraInc = {sqlType:sql:Type.INTEGER, value:inc, direction:sql:Direction.IN};
            paraCount = {sqlType:sql:Type.INTEGER, value:count, direction:sql:Direction.INOUT};
            paraShipped = {sqlType:sql:Type.INTEGER, direction:sql:Direction.INOUT};
            paraCanceled = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraResolved = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraDisputed = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        }
        else if (status.equalsIgnoreCase("inouttoin")){
            paraCustomerNo = {sqlType:sql:Type.INTEGER, value:customerNo, direction:sql:Direction.IN};
            paraInc = {sqlType:sql:Type.INTEGER, value:inc, direction:sql:Direction.IN};
            paraCount = {sqlType:sql:Type.INTEGER, value:count, direction:sql:Direction.IN};
            paraShipped = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraCanceled = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraResolved = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraDisputed = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        }
        else if (status.equalsIgnoreCase("inouttoout")){
            paraCustomerNo = {sqlType:sql:Type.INTEGER, value:customerNo, direction:sql:Direction.IN};
            paraInc = {sqlType:sql:Type.INTEGER, value:inc, direction:sql:Direction.IN};
            paraCount = {sqlType:sql:Type.INTEGER, value:count, direction:sql:Direction.OUT};
            paraShipped = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraCanceled = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraResolved = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraDisputed = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        }
        else{
            paraCustomerNo = {sqlType:sql:Type.INTEGER, value:customerNo, direction:sql:Direction.IN};
            paraInc = {sqlType:sql:Type.INTEGER, value:inc, direction:sql:Direction.IN};
            paraCount = {sqlType:sql:Type.INTEGER, value:count, direction:sql:Direction.INOUT};
            paraShipped = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraCanceled = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraResolved = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraDisputed = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        }
        parameters = [paraCustomerNo, paraInc, paraShipped, paraCanceled, paraResolved, paraDisputed, paraCount];
        datatable dt = ep.call ("{call get_order_by_cust(?,?,?,?,?,?,?)}", parameters);
        dt.close();
    } catch (error e) {
        string msg = "Error in procedure call. Please retry";
        e = {msg:msg};
        err = e;
    }
    return paraShipped.value, paraCanceled.value, paraResolved.value, paraDisputed.value, paraCount.value, err;
}

function callProcedureWithLessInParams(int customerNo, string status)(any, any, any, any, any, error){

    endpoint<sql:ClientConnector> ep{

    }
    bind connInitS with ep;
    sql:Parameter[] parameters = [];
    error err;
    int inc = 5;
    int count = 0;
    sql:Parameter paraCustomerNo;
    sql:Parameter paraInc;
    sql:Parameter paraCount;
    sql:Parameter paraShipped;
    sql:Parameter paraCanceled;
    sql:Parameter paraResolved;
    sql:Parameter paraDisputed;
    sql:Parameter test;

    try {
        paraCustomerNo = {sqlType:sql:Type.INTEGER, value:customerNo, direction:sql:Direction.IN};
        paraInc = {sqlType:sql:Type.INTEGER, value:inc, direction:sql:Direction.IN};
        paraCount = {sqlType:sql:Type.INTEGER, value:count, direction:sql:Direction.INOUT};
        paraShipped = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        paraCanceled = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        paraResolved = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        paraDisputed = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        parameters = [paraCustomerNo, test,  paraShipped, paraCanceled, paraResolved, paraDisputed, paraCount];
        if (status.equalsIgnoreCase("select")){
            parameters = [test, paraInc,  paraShipped, paraCanceled, paraResolved, paraDisputed, paraCount];
        }
        else{
            parameters = [paraCustomerNo, test,  paraShipped, paraCanceled, paraResolved, paraDisputed, paraCount];
        }
        datatable dt = ep.call ("{call get_order_by_cust(?,?,?,?,?,?,?)}", parameters);
        dt.close();
    } catch (error e) {
        string msg = "Error in procedure call. Please retry";
        e = {msg:msg};
        err = e;
    }
    return paraShipped.value, paraCanceled.value, paraResolved.value, paraDisputed.value, paraCount.value, err;
}

function callProcedureWithLessOutParams(int customerNo)(any, any, any, any, any, error){

    endpoint<sql:ClientConnector> ep{

    }
    bind connInitS with ep;
    sql:Parameter[] parameters = [];
    error err;
    int inc = 5;
    int count = 0;
    sql:Parameter paraCustomerNo;
    sql:Parameter paraInc;
    sql:Parameter paraCount;
    sql:Parameter paraShipped;
    sql:Parameter paraCanceled;
    sql:Parameter paraResolved;
    sql:Parameter paraDisputed;
    sql:Parameter test;

    try {
        paraCustomerNo = {sqlType:sql:Type.INTEGER, value:customerNo, direction:sql:Direction.IN};
        paraInc = {sqlType:sql:Type.INTEGER, value:inc, direction:sql:Direction.IN};
        paraCount = {sqlType:sql:Type.INTEGER, value:count, direction:sql:Direction.INOUT};
        paraShipped = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        paraCanceled = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        paraResolved = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        paraDisputed = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        parameters = [paraCustomerNo, paraInc,  test, paraCanceled, paraResolved, paraDisputed, paraCount];
        datatable dt = ep.call ("{call get_order_by_cust(?,?,?,?,?,?,?)}", parameters);
        dt.close();
    } catch (error e) {
        string msg = "Error in procedure call. Please retry";
        e = {msg:msg};
        err = e;
    }
    return paraShipped.value, paraCanceled.value, paraResolved.value, paraDisputed.value, paraCount.value, err;
}

function callProcedureWithLessInOutParams(int customerNo)(any, any, any, any, any, error){

    endpoint<sql:ClientConnector> ep{

    }
    bind connInitS with ep;
    sql:Parameter[] parameters = [];
    error err;
    int inc = 5;
    int count = 0;
    sql:Parameter paraCustomerNo;
    sql:Parameter paraInc;
    sql:Parameter paraCount;
    sql:Parameter paraShipped;
    sql:Parameter paraCanceled;
    sql:Parameter paraResolved;
    sql:Parameter paraDisputed;
    sql:Parameter test;

    try {
        paraCustomerNo = {sqlType:sql:Type.INTEGER, value:customerNo, direction:sql:Direction.IN};
        paraInc = {sqlType:sql:Type.INTEGER, value:inc, direction:sql:Direction.IN};
        paraCount = {sqlType:sql:Type.INTEGER, value:count, direction:sql:Direction.INOUT};
        paraShipped = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        paraCanceled = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        paraResolved = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        paraDisputed = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        parameters = [paraCustomerNo, paraInc,  paraShipped, paraCanceled, paraResolved, paraDisputed, test];
        datatable dt = ep.call ("{call get_order_by_cust(?,?,?,?,?,?,?)}", parameters);
        dt.close();
    } catch (error e) {
        string msg = "Error in procedure call. Please retry";
        e = {msg:msg};
        err = e;
    }
    return paraShipped.value, paraCanceled.value, paraResolved.value, paraDisputed.value, paraCount.value, err;
}

function callProcedureWithMismatchingParams(int customerNo, string status)(any, any, any, any, any, error){

    endpoint<sql:ClientConnector> ep{

    }
    bind connInitS with ep;
    sql:Parameter[] parameters = [];
    error err;
    int inc = 5;
    int count = 0;
    sql:Parameter paraCustomerNo;
    sql:Parameter paraInc;
    sql:Parameter paraCount;
    sql:Parameter paraShipped;
    sql:Parameter paraCanceled;
    sql:Parameter paraResolved;
    sql:Parameter paraDisputed;

    try {
        if (status.equalsIgnoreCase("invaluenotchanged")){
            paraCustomerNo = {sqlType:sql:Type.INTEGER, value:customerNo, direction:sql:Direction.IN};
            paraInc = {sqlType:sql:Type.VARCHAR, value:inc, direction:sql:Direction.IN};
            paraCount = {sqlType:sql:Type.INTEGER, value:count, direction:sql:Direction.INOUT};
            paraShipped = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraCanceled = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraResolved = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraDisputed = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        }
        else if (status.equalsIgnoreCase("invaluechanged")){
            paraCustomerNo = {sqlType:sql:Type.INTEGER, value:customerNo, direction:sql:Direction.IN};
            paraInc = {sqlType:sql:Type.VARCHAR, value:"test", direction:sql:Direction.IN};
            paraCount = {sqlType:sql:Type.INTEGER, value:count, direction:sql:Direction.INOUT};
            paraShipped = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraCanceled = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraResolved = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraDisputed = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        }
        else if(status.equalsIgnoreCase("inonlyvaluechanged")){
            paraCustomerNo = {sqlType:sql:Type.INTEGER, value:customerNo, direction:sql:Direction.IN};
            paraInc = {sqlType:sql:Type.INTEGER, value:"test", direction:sql:Direction.IN};
            paraCount = {sqlType:sql:Type.INTEGER, value:count, direction:sql:Direction.INOUT};
            paraShipped = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraCanceled = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraResolved = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraDisputed = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        }
        else if (status.equalsIgnoreCase("out")){
            paraCustomerNo = {sqlType:sql:Type.INTEGER, value:customerNo, direction:sql:Direction.IN};
            paraInc = {sqlType:sql:Type.INTEGER, value:inc, direction:sql:Direction.IN};
            paraCount = {sqlType:sql:Type.INTEGER, value:count, direction:sql:Direction.INOUT};
            paraShipped = {sqlType:sql:Type.VARCHAR, direction:sql:Direction.OUT};
            paraCanceled = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraResolved = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraDisputed = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        }
        else if (status.equalsIgnoreCase("inoutvaluenotchanged")){
            paraCustomerNo = {sqlType:sql:Type.INTEGER, value:customerNo, direction:sql:Direction.IN};
            paraInc = {sqlType:sql:Type.INTEGER, value:inc, direction:sql:Direction.IN};
            paraCount = {sqlType:sql:Type.VARCHAR, value:count, direction:sql:Direction.INOUT};
            paraShipped = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraCanceled = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraResolved = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraDisputed = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        }
        else if (status.equalsIgnoreCase("inoutvaluechanged")){
            paraCustomerNo = {sqlType:sql:Type.INTEGER, value:customerNo, direction:sql:Direction.IN};
            paraInc = {sqlType:sql:Type.INTEGER, value:inc, direction:sql:Direction.IN};
            paraCount = {sqlType:sql:Type.VARCHAR, value:"test", direction:sql:Direction.INOUT};
            paraShipped = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraCanceled = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraResolved = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraDisputed = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        }
        else if (status.equalsIgnoreCase("inoutonlyvaluechanged")){
            paraCustomerNo = {sqlType:sql:Type.INTEGER, value:customerNo, direction:sql:Direction.IN};
            paraInc = {sqlType:sql:Type.INTEGER, value:inc, direction:sql:Direction.IN};
            paraCount = {sqlType:sql:Type.INTEGER, value:"test", direction:sql:Direction.INOUT};
            paraShipped = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraCanceled = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraResolved = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraDisputed = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        }
        else{
            paraCustomerNo = {sqlType:sql:Type.INTEGER, value:customerNo, direction:sql:Direction.IN};
            paraInc = {sqlType:sql:Type.INTEGER, value:inc, direction:sql:Direction.IN};
            paraCount = {sqlType:sql:Type.INTEGER, value:count, direction:sql:Direction.INOUT};
            paraShipped = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraCanceled = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraResolved = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
            paraDisputed = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        }
        parameters = [paraCustomerNo, paraInc, paraShipped, paraCanceled, paraResolved, paraDisputed, paraCount];
        datatable dt = ep.call ("{call get_order_by_cust(?,?,?,?,?,?,?)}", parameters);
        dt.close();
    } catch (error e) {
        string msg = "Error in procedure call. Please retry";
        e = {msg:msg};
        err = e;
    }
    return paraShipped.value, paraCanceled.value, paraResolved.value, paraDisputed.value, paraCount.value, err;
}

function callProcedureToGetResultSet(int customerNo)(json, error){

    endpoint<sql:ClientConnector> ep{

    }
    bind connInitS with ep;
    sql:Parameter[] parameters = [];
    error err;
    error typeErr;
    int inc = 5;
    int count = 0;
    sql:Parameter paraCustomerNo;
    sql:Parameter paraInc;
    sql:Parameter paraCount;
    sql:Parameter paraShipped;
    sql:Parameter paraCanceled;
    sql:Parameter paraResolved;
    sql:Parameter paraDisputed;
    datatable dt;
    json result;

    try {
        paraCustomerNo = {sqlType:sql:Type.INTEGER, value:customerNo, direction:sql:Direction.IN};
        paraInc = {sqlType:sql:Type.INTEGER, value:inc, direction:sql:Direction.IN};
        paraCount = {sqlType:sql:Type.INTEGER, value:count, direction:sql:Direction.INOUT};
        paraShipped = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        paraCanceled = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        paraResolved = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        paraDisputed = {sqlType:sql:Type.INTEGER, direction:sql:Direction.OUT};
        parameters = [paraCustomerNo, paraInc, paraShipped, paraCanceled, paraResolved, paraDisputed, paraCount];
        dt = ep.call ("{call get_order_by_cust(?,?,?,?,?,?,?)}", parameters);
        result, _ = <json>dt;
    } catch (error e) {
        string msg = "Error in procedure call. Please retry";
        e = {msg:msg};
        err = e;
    }
    return result, err;
}

