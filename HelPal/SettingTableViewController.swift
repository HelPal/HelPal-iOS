//
//  SettingTableViewController.swift
//  HelPal
//
//  Created by zhongdian on 2017/3/2.
//  Copyright © 2017年 CodeAsO. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController{
    
    override func viewDidLoad() {
        self.title = "SettingNavTitle".localized;
        self.tableView.delegate = self;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
    }
}
