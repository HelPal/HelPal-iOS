//
//  JsonMocker.swift
//  HelPal
//
//  Created by Dian Zhong on 10/04/2017.
//  Copyright © 2017 CodeAsO. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

final class JsonMocker {
    
    static let responseDelay = 3000;
    
    //use lazy init for long things
    lazy var mockAPIs: Array<JsonMockModel> = {
        var temp = Array<JsonMockModel>();
        
        //Sync with https://www.showdoc.cc/home/item/show/item_id/14521
        //User Life Cycle
        //log in
        temp.append(JsonMockModel(route: "/v1/user/login", method: .get, example: [
            "accessToken" : "fakeToken",
            "status" : 0]));
        //sign up
        temp.append(JsonMockModel(route: "/v1/user/signup", method: .get, example: [
            "accessToken" : "fakeToken",
            "status" : 0]));
        //set avatar
        temp.append(JsonMockModel(route: "/v1/user/setAvatar", method: .post, example: [
            "avatarUrl" : "URL",
            "status" : 0]));
        //get user info, request need username as para,
        //or set username as empty, use accesstoken to get own info
        temp.append(JsonMockModel(route: "/v1/user/info", method: .get, example: [
            "status": 0,
            "username": "Jack",
            "gender": "male" ,
            "age": 22,
            "star_signs": "xx",
            "skills": ["a","b","c"],
            "interests": ["l","g"],
            "motto": "ssss" ,
            "avatorUrl": "URL"]));
        //set user info
        temp.append(JsonMockModel(route: "/v1/user/setInfo", method: .post, example: [
            "avatarUrl" : "URL",
            "status" : 0]));
        //add 
        temp.append(JsonMockModel(route: "/v1/user/setInfo", method: .post, example: [
            "avatarUrl" : "URL",
            "status" : 0]));
        
        temp.append(JsonMockModel(route: "/v1/user/setInfo", method: .post, example: [
            "avatarUrl" : "URL",
            "status" : 0]));
        
        temp.append(JsonMockModel(route: "/v1/user/setInfo", method: .post, example: [
            "avatarUrl" : "URL",
            "status" : 0]));
        
        temp.append(JsonMockModel(route: "/v1/user/setInfo", method: .post, example: [
            "avatarUrl" : "URL",
            "status" : 0]));
        
        return temp;
    }();
    
    private init(){}
    
    static let sharedInstance: JsonMocker = JsonMocker();
    
    func mock(url: URLConvertible!, method:HTTPMethod = .get, completeHandler: @escaping (JSON) -> Void) {
        let urlTransformed = try? url.asURL();
        if urlTransformed == nil {
            log.warning("Use wrong para to fetch mock json!");
            completeHandler(JSON.null);
            return;
        }
        let path = urlTransformed!.path;
        let results = mockAPIs.filter{
            $0.route == path &&
            $0.method == method;
        };
        let delay = DispatchTime.now() + .milliseconds(JsonMocker.responseDelay)
        DispatchQueue.main.asyncAfter(deadline: delay, execute: { () -> Void in
            let random = Int(arc4random_uniform(UInt32(results.count)));
            if results.count == 0 {
                log.warning("API not found in the mock list");
                completeHandler(JSON.null);
                return;
            }
            completeHandler(results[random].example);
        });
    }
}

class JsonMockModel {
    var route: String!;
    var method: HTTPMethod!;
    var example: JSON!;
    init(route: String!, method: HTTPMethod = .get, example: JSON!) {
        self.route = route;
        self.example = example;
        self.method = method;
    }
}
