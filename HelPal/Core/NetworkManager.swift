//
//  NetworkManager.swift
//  HelPal
//
//  Created by Dian Zhong on 09/04/2017.
//  Copyright © 2017 CodeAsO. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

final class NetworkManager {
    
    var networkType: NetworkType!;
    
    private init(){
        if UniversalNetworkingMode == "mock" {
            self.networkType = .mock;
        } else if UniversalNetworkingMode == "compare" {
            self.networkType = .compare;
        } else{
            self.networkType = .product;
        }
    }
    
    static let sharedInstance: NetworkManager = NetworkManager();
    
    func loadJson(url: URLConvertible) -> Promise<NSDictionary> {
        return Promise { fulfill, reject in
            Alamofire.request(url).responseJSON { response in
                fulfill(response.result.value as! NSDictionary);
            }
        }
    }
}

enum NetworkType {
    case product;
    case mock;
    case compare;
}
