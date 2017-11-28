package resources.services;

import ballerina.net.http;
import ballerina.os;

@http:configuration {
    basePath:"/httpmethods"
}
service <http> HTTPMethodService {

    string connection = os:getEnv("TOMCAT_HOST");
    @http:resourceConfig {
        methods:["POST", "GET", "HEAD", "PUT", "DELETE"],
        path:"/all"
    }
    resource statusCodeResource (http:Request req, http:Response res) {
        endpoint<http:HttpClient> httpCheck {}
        http:HttpClient httpCh;
        httpCh = create http:HttpClient(connection, {});
        bind httpCh with httpCheck;
        http:Response clientResponse = {};
        string resourcePath = "/RESTfulService/mock/service/all";
        string method = req.getMethod();
        clientResponse, _ = httpCheck.execute(method, resourcePath, req);
        _ = res.forward(clientResponse);
    }

    @http:resourceConfig {
        methods:["HEAD"],
        path:"/head"
    }
    resource headResource (http:Request req, http:Response res) {
        endpoint<http:HttpClient> httpCheck {}
        http:HttpClient httpCh;
        httpCh = create http:HttpClient(connection, {});
        bind httpCh with httpCheck;
        http:Response clientResponse = {};
        string resourcePath = "/RESTfulService/mock/service/head";
        string method = "HEAD";
        clientResponse, _ = httpCheck.execute(method, resourcePath, req);
        _  = res.forward(clientResponse);
    }

    @http:resourceConfig {
        methods:["GET"],
        path:"/get"
    }
    resource getResource1 (http:Request req, http:Response res) {
        endpoint<http:HttpClient> httpCheck {}
        http:HttpClient httpCh;
        httpCh = create http:HttpClient(connection, {});
        bind httpCh with httpCheck;
        http:Response clientResponse = {};
        string resourcePath = "/RESTfulService/mock/service/get";
        string method = "GET";
        clientResponse, _ = httpCheck.execute(method, resourcePath, req);
        _ = res.forward(clientResponse);
    }

    @http:resourceConfig {
        methods:["POST"],
        path:"/post"
    }
    resource postResource1 (http:Request req, http:Response res) {
        endpoint<http:HttpClient> httpCheck {}
        http:HttpClient httpCh;
        httpCh = create http:HttpClient(connection, {});
        bind httpCh with httpCheck;
        http:Response clientResponse = {};
        string resourcePath = "/RESTfulService/mock/service/post";
        string method = "POST";
        clientResponse, _ = httpCheck.execute(method, resourcePath, req);
        _ = res.forward(clientResponse);
    }

    @http:resourceConfig {
        methods:["PUT"],
        path:"/put"
    }
    resource putResource1 (http:Request req, http:Response res) {
        endpoint<http:HttpClient> httpCheck {}
        http:HttpClient httpCh;
        httpCh = create http:HttpClient(connection, {});
        bind httpCh with httpCheck;
        http:Response clientResponse = {};
        string resourcePath = "/RESTfulService/mock/service/put";
        string method = "PUT";
        clientResponse, _ = httpCheck.execute(method, resourcePath, req);
        _ = res.forward(clientResponse);

    }

    @http:resourceConfig {
        methods:["GET"],
        path:"/gettopost"
    }
    resource getResource (http:Request req, http:Response res) {
        endpoint<http:HttpClient> httpCheck {}
        http:HttpClient httpCh;
        httpCh = create http:HttpClient(connection, {});
        bind httpCh with httpCheck;
        http:Response clientResponse = {};
        string resourcePath = "/RESTfulService/mock/service/post";
        string method = "POST";
        clientResponse, _ = httpCheck.execute(method, resourcePath, req);
        _ = res.forward(clientResponse);
    }

    @http:resourceConfig {
        methods:["GET"],
        path:"/doget"
    }
    resource getResource2 (http:Request req, http:Response res) {
        endpoint<http:HttpClient> httpCheck {}
        http:HttpClient httpCh;
        httpCh = create http:HttpClient(connection, {});
        bind httpCh with httpCheck;
        http:Response clientResponse = {};
        string resourcePath = "/RESTfulService/mock/service/get";
        clientResponse, _ = httpCheck.get(resourcePath, req);
        _ = res.forward(clientResponse);
    }

    @http:resourceConfig {
        methods:["POST"],
        path:"/posttoput"
    }
    resource postResource (http:Request req, http:Response res) {
        endpoint<http:HttpClient> httpCheck {}
        http:HttpClient httpCh;
        httpCh = create http:HttpClient(connection, {});
        bind httpCh with httpCheck;
        http:Response clientResponse = {};
        string resourcePath = "/RESTfulService/mock/service/put";
        string method = "PUT";
        clientResponse, _ = httpCheck.execute(method, resourcePath, req);
        _ = res.forward(clientResponse);
    }

    @http:resourceConfig {
        methods:["POST"],
        path:"/dopost"
    }
    resource postResource2 (http:Request req, http:Response res) {
        endpoint<http:HttpClient> httpCheck {}
        http:HttpClient httpCh;
        httpCh = create http:HttpClient(connection, {});
        bind httpCh with httpCheck;
        http:Response clientResponse = {};
        string resourcePath = "/RESTfulService/mock/service/post";
        clientResponse, _ = httpCheck.post(resourcePath, req);
        _ = res.forward(clientResponse);
    }

    @http:resourceConfig {
        methods:["PUT"],
        path:"/puttopost"
    }
    resource putResource (http:Request req, http:Response res) {
        endpoint<http:HttpClient> httpCheck {}
        http:HttpClient httpCh;
        httpCh = create http:HttpClient(connection, {});
        bind httpCh with httpCheck;
        http:Response clientResponse = {};
        string resourcePath = "/RESTfulService/mock/service/post";
        string method = "POST";
        clientResponse, _ = httpCheck.execute(method, resourcePath, req);
        _ = res.forward(clientResponse);
    }

    @http:resourceConfig {
        methods:["PUT"],
        path:"/doput"
    }
    resource putResource2 (http:Request req, http:Response res) {
        endpoint<http:HttpClient> httpCheck {}
        http:HttpClient httpCh;
        httpCh = create http:HttpClient(connection, {});
        bind httpCh with httpCheck;
        http:Response clientResponse = {};
        string resourcePath = "/RESTfulService/mock/service/put";
        clientResponse, _ = httpCheck.put(resourcePath, req);
        _ = res.forward(clientResponse);
    }
}