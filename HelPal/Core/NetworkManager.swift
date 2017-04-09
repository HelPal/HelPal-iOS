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
    
    func loadJson(url: URLConvertible, method: HTTPMethod = .get, paras: [String: Any]? = nil, headers: HTTPHeaders? = nil) -> Promise<NSDictionary>{
        return Promise { fulfill, reject in
            Alamofire.request(url, method: method, parameters: paras, encoding: URLEncoding.default, headers: headers)
                .validate()
                .responseJSON{ response in
                    switch response.result {
                    case .success(let dict):
                        fulfill(dict as! NSDictionary)
                    case .failure(let error):
                        reject(error)
                    }
            }
        }
    }
    

}

enum NetworkType {
    case product;
    case mock;
    case compare;
}
