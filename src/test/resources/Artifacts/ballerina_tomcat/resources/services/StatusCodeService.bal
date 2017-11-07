package resources.services;

import ballerina.net.http;
import ballerina.os;

@http:configuration {
    basePath:"/statuscode"
}
service <http> StatusCodeService {

    string connection = os:getEnv("TOMCAT_HOST");
    @http:resourceConfig {
        methods:["POST", "GET"],
        path:"/code/{code}"
    }
    resource statusCodeResource (http:Request req, http:Response res, string code) {
        endpoint<http:HttpClient> httpCheck {}
        http:HttpClient httpCh;
        httpCh = create http:HttpClient(connection, {});
        bind httpCh with httpCheck;
        http:Response clientResponse = {};
        map params = req.getQueryParams();
        var withbody, _ = (string)params.withbody;
        println(withbody);
        string resourcePath = "/RESTfulService/mock/statusCodeService/" + code + "?withbody=" + withbody;
        string method = req.getMethod();
        clientResponse, _ = httpCheck.execute(method, resourcePath, req);
        res.forward(clientResponse);
    }

    @http:resourceConfig {
        methods:["HEAD"],
        path:"/code/{code}"
    }
    resource statusCodeResource2 (http:Request req, http:Response res, string code) {
        endpoint<http:HttpClient> httpCheck {}
        http:HttpClient httpCh;
        httpCh = create http:HttpClient(connection, {});
        bind httpCh with httpCheck;
        http:Response clientResponse = {};
        string resourcePath = "/RESTfulService/mock/statusCodeService/" + code;
        string method = req.getMethod();
        clientResponse, _ = httpCheck.execute(method, resourcePath, req);
        res.forward(clientResponse);
    }
}