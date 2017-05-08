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
import OHHTTPStubs
import SwiftyJSON

enum NetworkType {
    case product;
    case mock;
    case compare;
}

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
    
    /// Server protocol, IP and port, and version
    static let domain: String! = "http://112.74.53.157:8080/Helpal";
    
    func loadJson(url: URLConvertible, method: HTTPMethod = .get, paras: [String: Any]? = nil, headers: HTTPHeaders? = nil) -> Promise<JSON>{
        
        //If in mock mode, returns the saved profile
        if self.networkType == .mock {
            return Promise { fulfill, reject in
                JsonMocker.sharedInstance.mock(url: url, completeHandler: { json in
                    fulfill(json)
                })
            }
        }
        //Note that in compare mode, we need to fetch data from server as well as mock it locally,
        //which means it shares same lines of codes below and above, but I haven't found a good idea to do componentization
            
        //In most case, we return the server's reponse.
        else {
            
            return Promise { fulfill, reject in
                Alamofire.request(url, method: method, parameters: paras, encoding: URLEncoding.default, headers: headers)
                    .validate()
                    .responseJSON{ response in
                        switch response.result {
                        case .success(let dict):
                            let json = JSON(dict)
                            fulfill(json);
                        case .failure(let error):
                            reject(error);
                        }
                }
            }
        }
        
    }
}



