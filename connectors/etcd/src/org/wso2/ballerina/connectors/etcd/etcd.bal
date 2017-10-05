package org.wso2.ballerina.connectors.etcd;

import ballerina.doc;
import ballerina.lang.messages;
import ballerina.lang.strings;
import ballerina.net.http;
import ballerina.utils;

@doc:Description { value:"etcd client connector"}
@doc:Param { value:"etcdURL : etcd Server URL"}
@doc:Param { value:"username : etcd user"}
@doc:Param { value:"password : etcd user's password"}
@doc:Param { value:"apiVersion : etcd API version"}
connector ClientConnector (string etcdURL, string username, string password, string apiVersion) {

    http:ClientConnector etcdEP = create http:ClientConnector(etcdURL);

    @doc:Description { value:"Get the value for given key"}
    @doc:Param { value:"key: key to get the value"}
    @doc:Return { value:"response object"}
    action getValue (string key) (message) {

        string encodedBasicAuthHeaderValue;
        string path;
        message request = {};
        message response;

        if ((strings:length(username) > 0) && (strings:length(password) > 0)) {
            encodedBasicAuthHeaderValue = utils:base64encode(username + ":" + password);
            messages:setHeader(request, "Authorization", "Basic " + encodedBasicAuthHeaderValue);
        }
        path = "/" + apiVersion + "/keys/" + key;
        response = etcdEP.get (path, request);
        return response;
    }

    @doc:Description { value:"Set/Store key/value pair"}
    @doc:Param { value:"key: key to set the value"}
    @doc:Param { value:"value: value for the key"}
    @doc:Return { value:"response object"}
    action setKeyValue (string key, string value) (message) {

        string encodedBasicAuthHeaderValue;
        string path;
        message request = {};
        message response;

        if ((strings:length(username) > 0) && (strings:length(password) > 0)) {
            encodedBasicAuthHeaderValue = utils:base64encode(username + ":" + password);
            messages:setHeader(request, "Authorization", "Basic " + encodedBasicAuthHeaderValue);
        }
        messages:setStringPayload(request, "value=" + value);
        messages:setHeader(request, "Content-Type", "application/x-www-form-urlencoded");
        path = "/" + apiVersion + "/keys/" + key;
        response = etcdEP.put (path, request);
        return response;
    }

    @doc:Description { value:"Update the value for given key"}
    @doc:Param { value:"key: key to update the value"}
    @doc:Param { value:"value: value for the key"}
    @doc:Return { value:"response object"}
    action updateValue (string key, string value) (message) {

        string encodedBasicAuthHeaderValue;
        string path;
        message request = {};
        message response;

        if ((strings:length(username) > 0) && (strings:length(password) > 0)) {
            encodedBasicAuthHeaderValue = utils:base64encode(username + ":" + password);
            messages:setHeader(request, "Authorization", "Basic " + encodedBasicAuthHeaderValue);
        }
        messages:setStringPayload(request, "value=" + value);
        messages:setHeader(request, "Content-Type", "application/x-www-form-urlencoded");
        path = "/" + apiVersion + "/keys/" + key;
        response = etcdEP.put (path, request);
        return response;
    }

    @doc:Description { value:"Delete the key"}
    @doc:Param { value:"key: key to delete"}
    @doc:Return { value:"response object"}
    action deleteKey (string key) (message) {

        string encodedBasicAuthHeaderValue;
        string path;
        message request = {};
        message response;

        if ((strings:length(username) > 0) && (strings:length(password) > 0)) {
            encodedBasicAuthHeaderValue = utils:base64encode(username + ":" + password);
            messages:setHeader(request, "Authorization", "Basic " + encodedBasicAuthHeaderValue);
        }
        path = "/" + apiVersion + "/keys/" + key;
        response = etcdEP.delete (path, request);
        return response;
    }

    @doc:Description { value:"Create a directory"}
    @doc:Param { value:"dir: name of the directory"}
    @doc:Return { value:"response object"}
    action createDir (string dir) (message) {

        string encodedBasicAuthHeaderValue;
        string path;
        message request = {};
        message response;

        if ((strings:length(username) > 0) && (strings:length(password) > 0)) {
            encodedBasicAuthHeaderValue = utils:base64encode(username + ":" + password);
            messages:setHeader(request, "Authorization", "Basic " + encodedBasicAuthHeaderValue);
        }
        path = "/" + apiVersion + "/keys/" + dir;
        response = etcdEP.put (path, request);
        return response;
    }

    @doc:Description { value:"List directory"}
    @doc:Param { value:"dir: name of the directory"}
    @doc:Param { value:"recursive: recursive=true OR recursive=false"}
    @doc:Return { value:"response object"}
    action listDir (string dir, string recursive) (message) {

        string encodedBasicAuthHeaderValue;
        string path;
        message request = {};
        message response;

        if ((strings:length(username) > 0) && (strings:length(password) > 0)) {
            encodedBasicAuthHeaderValue = utils:base64encode(username + ":" + password);
            messages:setHeader(request, "Authorization", "Basic " + encodedBasicAuthHeaderValue);
        }
        path = "/" + apiVersion + "/keys" + dir + "?" + recursive;
        response = etcdEP.get (path, request);
        return response;
    }

    @doc:Description { value:"Delete directory"}
    @doc:Param { value:"dir: name of the directory"}
    @doc:Param { value:"recursive: recursive=true OR recursive=false"}
    @doc:Return { value:"response object"}
    action deleteDir (string dir, string recursive) (message) {

        string encodedBasicAuthHeaderValue;
        string path;
        message request = {};
        message response;

        if ((strings:length(username) > 0) && (strings:length(password) > 0)) {
            encodedBasicAuthHeaderValue = utils:base64encode(username + ":" + password);
            messages:setHeader(request, "Authorization", "Basic " + encodedBasicAuthHeaderValue);
        }
        path = "/" + apiVersion + "/keys" + dir + "?" + recursive;
        response = etcdEP.delete (path, request);
        return response;
    }
}
