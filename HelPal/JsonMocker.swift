//
//  JsonMocker.swift
//  HelPal
//
//  Created by Dian Zhong on 10/04/2017.
//  Copyright © 2017 CodeAsO. All rights reserved.
//

import Foundation
import SwiftyJSON

final class JsonMocker {
    
    static let responseDelay = 3000;
    
    //use lazy init for long things
    lazy var mockAPIs: Array<JsonMockModel> = {
        var temp = Array<JsonMockModel>();
        temp.append(JsonMockModel(route: "v1/user/login", example: [
            "accessToken" : "fakeToken",
            "status" : "true"]));
        return temp;
    }();
    
    private init(){}
    
    static let sharedInstance: JsonMocker = JsonMocker();
    
    func mock(path: String!, completeHandler: @escaping (JSON) -> Void) {
        let delay = DispatchTime.now() + .milliseconds(JsonMocker.responseDelay)
        DispatchQueue.main.asyncAfter(deadline: delay, execute: { () -> Void in
            completeHandler(self.mockAPIs[0].example);
        });
    }
}

class JsonMockModel {
    var route: String!;
    var example: JSON!;
    init(route: String!, example: JSON!) {
        self.route = route;
        self.example = example;
    }
}
