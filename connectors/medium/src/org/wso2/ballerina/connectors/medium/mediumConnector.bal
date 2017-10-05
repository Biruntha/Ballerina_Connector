package org.wso2.ballerina.connectors.medium;

import org.wso2.ballerina.connectors.oauth2;
import ballerina.doc;
import ballerina.lang.messages;

@doc:Description{ value : "Medium client connector"}
@doc:Param{ value : "accessToken: The access token of the Medium Application"}
@doc:Param{ value : "clientId: Client Id of the Medium Application"}
@doc:Param{ value : "clientSecret: Client Secret of the Medium Application"}
@doc:Param{ value : "refreshToken: The refresh token of the Medium Application"}
connector ClientConnector (string accessToken, string clientId, string clientSecret, string refreshToken) {

    string refreshTokenEP = "https://api.medium.com/v1/tokens";
    string baseURL = "https://api.medium.com";
    oauth2:ClientConnector mediumEP = create oauth2:ClientConnector(baseURL, accessToken, clientId, clientSecret,
        refreshToken, refreshTokenEP);

    @doc:Description{ value : "Get Profile Information"}
    @doc:Return{ value : "response object"}
    action getProfileInfo() (message) {

        string getProfileInfoPath;
        message request = {};
        message response;
        getProfileInfoPath = "/v1/me";
        response = mediumEP.get(getProfileInfoPath, request);

        return response;
    }

    @doc:Description{ value : "Get List of Contributors for a Publication"}
    @doc:Param{ value : "publicationId: ID of relevant publication"}
    @doc:Return{ value : "response object"}
    action getContributors(string publicationId) (message) {

        string getContributorsPath;
        message request = {};
        message response;

        getContributorsPath = "/v1/publications/" + publicationId + "/contributors";
        response = mediumEP.get(getContributorsPath, request);

        return response;
    }

    @doc:Description{ value : "Get List of Publications the user have contributed"}
    @doc:Param{ value : "userId: ID of authenticated user"}
    @doc:Return{ value : "response object"}
    action getPublications(string userId) (message) {

        string getPublicationsPath;
        message request = {};
        message response;

        getPublicationsPath = "/v1/users/" + userId + "/publications";
        response = mediumEP.get(getPublicationsPath, request);

        return response;
    }

    @doc:Description{ value : "Create Post in authenticated User's profile"}
    @doc:Param{ value : "userId: ID of authenticated user"}
    @doc:Param{ value : "payload: json payload containing the post"}
    @doc:Return{ value : "response object"}
    action createProfilePost(string userId, json payload) (message) {

        string createProfilePostPath;
        message request = {};
        message response;

        createProfilePostPath = "/v1/users/" + userId + "/posts";
        messages:setHeader(request, "Content-Type", "application/json");
        messages:setJsonPayload(request, payload);
        response = mediumEP.post(createProfilePostPath, request);

        return response;
    }

    @doc:Description{ value : "Get List of Contributors for a Publication"}
    @doc:Param{ value : "publicationId: ID of relevant publication"}
    @doc:Param{ value : "payload: json payload containing the post"}
    @doc:Return{ value : "response object"}
    action createPublicationPost(string publicationId, json payload) (message) {

        string createPublicationPostPath;
        message request = {};
        message response;

        createPublicationPostPath = "/v1/publications/" + publicationId + "/posts";
        messages:setHeader(request, "Content-Type", "application/json");
        messages:setJsonPayload(request, payload);
        response = mediumEP.post(createPublicationPostPath, request);

        return response;
    }
}

