//
//  MainTabbarViewController.swift
//  HelPal
//
//  Created by zhongdian on 2017/3/2.
//  Copyright © 2017年 CodeAsO. All rights reserved.
//

import UIKit

// This is the entrance of the app
class MainTabbarViewController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.items![0].title = "ChatlistTabTitle".localized;
        self.tabBar.items![1].title = "RecommonTabTitle".localized;
        self.tabBar.items![2].title = "SettingTabTitle".localized;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
