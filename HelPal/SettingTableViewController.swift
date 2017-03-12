//
//  SettingTableViewController.swift
//  HelPal
//
//  Created by zhongdian on 2017/3/2.
//  Copyright © 2017年 CodeAsO. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController{
    
    @IBOutlet weak var genderLabel: UILabel!
    
    var genderSheet: UIAlertController!;
    override func viewDidLoad() {
        self.title = "SettingNavTitle".localized;
        self.tableView.delegate = self;
        
        //Setting gender sheet
        genderSheet = UIAlertController(title: "ChooseYourGender".localized, message: nil, preferredStyle: .actionSheet);
        let maleAction = UIAlertAction(title: "Male".localized, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.setGender(type: "male");
        });
        let femaleAction = UIAlertAction(title: "Female".localized, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.setGender(type: "female");
        });
        let cancelAction = UIAlertAction(title: "Cancel".localized, style: .cancel, handler:nil);
        genderSheet.addAction(maleAction);
        genderSheet.addAction(femaleAction);
        genderSheet.addAction(cancelAction);
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
        } else {
            switch indexPath.row {
            case 0:
                self.present(genderSheet, animated:true, completion:nil);
            default:
                print("click somewhere not paid attention");
            }
        }
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    func setGender(type: String!){
        //TODO:
        if type == "male" {
            genderLabel.text = "Male".localized;
        } else if type == "female" {
            genderLabel.text = "Female".localized;
        }
    }
}
