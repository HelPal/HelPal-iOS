//
//  SearchTableViewController.swift
//  HelPal
//
//  Created by Dian Zhong on 09/05/2017.
//  Copyright © 2017 CodeAsO. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    var queryStr: String?;
    
    override func viewDidLoad() {
        let searchBar = UISearchBar() // Create your search bar
        self.navigationItem.titleView = searchBar;
        searchBar.delegate = self;
        let tapper = UITapGestureRecognizer(target: self, action: #selector(tapOn(tap:)));
        self.tableView.addGestureRecognizer(tapper);
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath);
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        queryStr = searchText;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.tableView.reloadData();
    }
    
    //TODO:
    //make the search page dynamic
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if queryStr != nil && queryStr != ""{
            return 1;
        } else {
            return 0;
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        cell.textLabel?.text = "发布关于\"" + queryStr! + "\"的需求或服务";
        return cell
    }
    
    @objc func tapOn(tap: UITapGestureRecognizer){
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
