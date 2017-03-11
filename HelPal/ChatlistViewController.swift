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
    override func viewDidLoad() {
        self.title = "ChatlistNavTitle".localized;
    }
}
