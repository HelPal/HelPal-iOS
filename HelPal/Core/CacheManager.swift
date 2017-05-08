//
//  CacheManager.swift
//  HelPal
//
//  Created by Dian Zhong on 08/05/2017.
//  Copyright © 2017 CodeAsO. All rights reserved.
//

import Foundation

final class CacheManager {
    
    private let defaults : UserDefaults!;
    
    private init(){
        defaults = UserDefaults.standard;
    }
    
    static let sharedInstance: CacheManager = CacheManager();
    
    //TODO:
    //Maybe we should use NSCoding so that we can store custom objects rather than string only
    func setCache(key: CacheKeys, value: String){
        defaults.set(value, forKey: key.rawValue);
        defaults.synchronize();
    }
    
    func getCache(key: CacheKeys) -> String?{
        return defaults.string(forKey: key.rawValue);
    }
}

enum CacheKeys: String {
    case accessToken = "accessToken";
    case settingGender = "settingGender";
}
