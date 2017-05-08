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
        let tapper = UITapGestureRecognizer(target: self, action: #selector(tapOn(tap:)));
        self.tableView.addGestureRecognizer(tapper);
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath);
    }
    
    func tapOn(tap: UITapGestureRecognizer){
        let location = tap.location(in: self.tableView);
        let path = self.tableView.indexPathForRow(at: location);
        if path == nil {
            quitSearch();
        } else{
            self.tableView(self.tableView, didSelectRowAt: path!);
        }
    }
    
    func quitSearch(){
        self.dismiss(animated: true, completion: nil);
    }
}
