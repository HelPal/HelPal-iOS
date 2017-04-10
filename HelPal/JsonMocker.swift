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
        //
        temp.append(JsonMockModel(route: "/v1/user/login", method: .get, example: [
            "accessToken" : "fakeToken",
            "status" : "true"]));
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
