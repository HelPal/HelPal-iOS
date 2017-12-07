//
//  UserLifeCycle.swift
//  HelPal
//
//  Created by Dian Zhong on 08/05/2017.
//  Copyright © 2017 CodeAsO. All rights reserved.
//

import Foundation
import PromiseKit
import SwiftyJSON

/*
 * Apple recommends developers to use MVC in iOS apps, which is Model, View, ViewController.
 * But after doing some work you will notice ViewController can be extra heavy in a complex app.
 * So I learned something from so-called Three-tier Architecture, which is Presentation, Business Logic and Data
 * Views and ViewControllers will do the presentation
 * NetworkManager and CacheManager get data from server and local
 * And here is the Business Logic, actually when you use a verb to describe what the app really doing, you can find that verb here.
 * This Architecture is well designed, but the implemation has a problem.
 * ViewController want something to be done by Bussiness Logic. Usually these tasks take a while to finish. So the ViewController will continue running before Bussiness Logic function actually returns. This is want we called async.
 * To achieve that we will need get a callback function as a parameter to Bussiness Logic function. When the later function truly finished, it calls the callback.
 * This is simple and elegant, but not in a complex app. Say if View Controller want to perform task A and task B, how to determine whether they've all done?
 * Complex situations like this will lead you to a place called Callback hell.
 * To solve this, I introduced Promise in NetworkManager. You can read document about Promise in JavaScript and PromiseKit.
 * Problem is I just introduce Promise in Data Level, which is NetworkManager here. You may need to re-structure every BusinessLogic method to pass Promise<T> to View Controller.
 * Or you can take a step further, using RxSwift, it's a brand new way to program. Check some documents about it and MVVM.
 */
class UserLifeCycle {
    
    static func isLoggedIn() -> Bool{
        //TODO:
        //check the token online
        return CacheManager.sharedInstance.getCache(key: .accessToken) != nil;
    }
    
    static func login(username: String, rawPwd: String, completeHandler:@escaping (Bool, String?) -> (Void) ){
        
        let url = NetworkManager.domain + "/user/login?username=" + username + "&password=" + Support.md5(rawPwd);
        
        NetworkManager.sharedInstance.loadJson(url: url).then{ result -> Void in
            if result["accessToken"].string != nil {
                CacheManager.sharedInstance.setCache(key: .username, value: username);
                CacheManager.sharedInstance.setCache(key: .accessToken, value: result["accessToken"].string!);
                completeHandler(true, nil);
            } else {
                completeHandler(false, result["errorMsg"].string!);
            }
        }.catch{error -> Void in
            completeHandler(false, error.localizedDescription);
        }
    }
    
    static func signup(username: String, rawPwd: String, completeHandler:@escaping (Bool, String?) -> (Void) ){
        
        let url = NetworkManager.domain + "/user/signup?username=" + username + "&password=" + Support.md5(rawPwd);
        
        NetworkManager.sharedInstance.loadJson(url: url, method: .post).then{ result -> Void in
            if result["accessToken"].string != nil {
                CacheManager.sharedInstance.setCache(key: .username, value: username);
                CacheManager.sharedInstance.setCache(key: .accessToken, value: result["accessToken"].string!);
                completeHandler(true, nil);
            } else {
                completeHandler(false, result["errorMsg"].string!);
            }
            }.catch{error -> Void in
                completeHandler(false, error.localizedDescription);
        }
    }
    
    static func getUserInfo(username: String, completeHandler:@escaping (Bool, String?, JSON?) -> (Void) ){
        
        let url = NetworkManager.domain + "/user/info?username=" + username;
        
        NetworkManager.sharedInstance.loadJson(url: url, method: .get).then{ result -> Void in
            if result["Status"].number == 0 {
                completeHandler(true, nil, result["User"]);
            } else {
                completeHandler(false, result["errorMsg"].string!, nil);
            }
            }.catch{error -> Void in
                completeHandler(false, error.localizedDescription, nil);
        }
    }
    
    //TODO:
    //backend need to update
    static func getMyUserInfo(completeHandler:@escaping (Bool, String?, JSON?) -> (Void) ){
        
        guard let token = CacheManager.sharedInstance.getCache(key: .accessToken) else {
            completeHandler(false, "not logged in", nil);
            return;
        }
        let url = NetworkManager.domain + "/user/info?accessToken=" + token;
        
        NetworkManager.sharedInstance.loadJson(url: url, method: .get).then{ result -> Void in
            if result["Status"].number == 0 {
                completeHandler(true, nil, result["User"]);
            } else {
                completeHandler(false, result["errorMsg"].string!, nil);
            }
            }.catch{error -> Void in
                completeHandler(false, error.localizedDescription, nil);
        }
    }
    
    //TODO:
    //backend should fix this, only one para is okay, I cannot post all the paras at the same time
    static func setGender(isMale: Bool, completeHandler:@escaping (Bool, String?) -> (Void) ){
        
        var gender: String!;
        if isMale {
            gender = "male";
        } else {
            gender = "female";
        }
        
        guard let token = CacheManager.sharedInstance.getCache(key: .accessToken) else {
            completeHandler(false, "not logged in");
            return;
        }
        let url = NetworkManager.domain + "/user/setInfo?accessToken=" + token + "&gender=" + gender + "&age=21&star_signs=33&motto=sad";
        
        NetworkManager.sharedInstance.loadJson(url: url, method: .post).then{ result -> Void in
            print(result);
            //return result.promise();
        }.catch{error -> Void in
            completeHandler(false, error.localizedDescription);
        }
    }
    
    static func editSkill(isAdd: Bool, skill: String!, completeHandler:@escaping (Bool, String?) -> (Void)){
        guard let token = CacheManager.sharedInstance.getCache(key: .accessToken) else {
            completeHandler(false, "not logged in");
            return;
        }
        let url = NetworkManager.domain + "/user/editSkill?accessToken=" + token + "&isAdd=" + String(isAdd) + "&skill="+skill;
        NetworkManager.sharedInstance.loadJson(url: url, method: .post).then{ result -> Void in
                print(result);
            }.catch{error -> Void in
                completeHandler(false, error.localizedDescription);
        }
    }
    
    static func editInterest(isAdd: Bool, interest: String!, completeHandler:@escaping (Bool, String?) -> (Void)){
        guard let token = CacheManager.sharedInstance.getCache(key: .accessToken) else {
            completeHandler(false, "not logged in");
            return;
        }
        let url = NetworkManager.domain + "/user/editInterest?accessToken=" + token + "&isAdd=" + String(isAdd) + "&interest="+interest;
        NetworkManager.sharedInstance.loadJson(url: url, method: .post).then{ result -> Void in
            print(result);
            }.catch{error -> Void in
                completeHandler(false, error.localizedDescription);
        }
    }
    
    static func logout(){
        CacheManager.sharedInstance.clearCache(key: .accessToken);
        CacheManager.sharedInstance.clearCache(key: .username);
        CacheManager.sharedInstance.clearCache(key: .settingGender);
    }
}
