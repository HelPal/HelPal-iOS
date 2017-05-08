//
//  SearchTableViewController.swift
//  HelPal
//
//  Created by Dian Zhong on 09/05/2017.
//  Copyright © 2017 CodeAsO. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    override func viewDidLoad() {
        let search = UISearchBar() // Create your search bar
        self.navigationItem.titleView = search;
    }
}
