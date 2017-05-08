//
//  ChatlistViewController.swift
//  HelPal
//
//  Created by zhongdian on 2017/3/2.
//  Copyright © 2017年 CodeAsO. All rights reserved.
//

import UIKit

//When the user is not logged in, this VC shows a message. Tab on anywhere will lead to the login ViewController
//When the user is logged in, this VC shows a chatlist
class ChatlistViewController: UIViewController
{
    @IBOutlet weak var emptyContainer: UIView!
    @IBOutlet weak var ListContainer: UIView!
    override func viewDidLoad() {
        self.title = "ChatlistNavTitle".localized;
        
        //TODO: Load measages
        //if messgaes.count = 0
        ListContainer.isHidden = true;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Now Use as Unit Test
        UserLifeCycle.login(username: "zhongdian", rawPwd: "19941201", completeHandler: {(suc, error) -> Void in
        })
    }
}
