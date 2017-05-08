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
    
    static func logout(){
        CacheManager.sharedInstance.clearCache(key: .accessToken);
        CacheManager.sharedInstance.clearCache(key: .username);
        CacheManager.sharedInstance.clearCache(key: .settingGender);
    }
}
