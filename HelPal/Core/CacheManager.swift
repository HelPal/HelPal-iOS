//
//  CacheManager.swift
//  HelPal
//
//  Created by Dian Zhong on 08/05/2017.
//  Copyright © 2017 CodeAsO. All rights reserved.
//

import Foundation

/*
 * In a mobile app we always need to persist the data, otherwise all the data we need will be lost next time user launches his or her app
 * There are many ways to do persisting. Most easy one are implemented here. We only stored the key-value pair.
 * But as the app grows complex, you may need to use a database to store data and query it.
 * You can use Sqlite to do this. We have FMDB and other frameworks helping us maintain a Sqlite database in app.
 * However, in a real complex app, Sqlite will be another shit you don't want to step on. In this case you may need Realm or other REAL database frameworks.
 * And always, don't use CoreData.
 */
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
    
    func clearCache(key: CacheKeys){
        defaults.removeObject(forKey: key.rawValue);
    }
}

enum CacheKeys: String {
    case accessToken = "accessToken";
    case username = "username";
    case settingGender = "settingGender";
}
