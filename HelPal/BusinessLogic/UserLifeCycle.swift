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
    
    static func login(username: String, rawPwd: String, completeHandler:@escaping (Bool, String?) -> (Void) ){
        
        let url = NetworkManager.domain + "/user/login?username=" + username + "&password=" + Support.md5(rawPwd);
        
        NetworkManager.sharedInstance.loadJson(url: url).then{ result -> Void in
            if result["accessToken"].string != nil {
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
                CacheManager.sharedInstance.setCache(key: .accessToken, value: result["accessToken"].string!);
                completeHandler(true, nil);
            } else {
                completeHandler(false, result["errorMsg"].string!);
            }
            }.catch{error -> Void in
                completeHandler(false, error.localizedDescription);
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
}
