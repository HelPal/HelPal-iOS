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
    
    static func login(username: String, rawPwd: String, completeHandler:@escaping (Bool, String) -> (Void) ){
        
        let url = NetworkManager.domain + "/user/login?username=" + username + "&password=" + Support.md5(rawPwd);
        
        NetworkManager.sharedInstance.loadJson(url: url).then{ result -> Void in
            print(result);
            //return result.promise();
        }.catch{error -> Void in
            completeHandler(false, error.localizedDescription);
        }
    }
    
    static func signup(username: String, rawPwd: String, completeHandler:@escaping (Bool, String) -> (Void) ){
        
        let url = NetworkManager.domain + "/user/signup?username=" + username + "&password=" + Support.md5(rawPwd);
        
        NetworkManager.sharedInstance.loadJson(url: url, method: .post).then{ result -> Void in
            print(result);
            //return result.promise();
            }.catch{error -> Void in
                completeHandler(false, error.localizedDescription);
        }
    }
    
    static func setGender(isMale: Bool, completeHandler:@escaping (Bool, String) -> (Void) ){
        
        NetworkManager.sharedInstance.loadJson(url: NetworkManager.domain + "/user/setInfo").then{ result -> Void in
            print(result);
            //return result.promise();
        }.catch{error -> Void in
            completeHandler(false, error.localizedDescription);
        }
    }
}
