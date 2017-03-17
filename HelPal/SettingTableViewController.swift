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
    @IBOutlet weak var mottoTitle: UILabel!
    @IBOutlet weak var skillTitle: UILabel!
    @IBOutlet weak var interestTitle: UILabel!
    @IBOutlet weak var genderTitle: UILabel!
    
    var genderSheet: UIAlertController!;
    var accountSheet: UIAlertController!;
    
    override func viewDidLoad() {
        self.title = "SettingNavTitle".localized;
        self.tableView.delegate = self;
        
        //Init view
        mottoTitle.text = "Motto".localized;
        skillTitle.text = "Skills".localized;
        interestTitle.text = "Interests".localized;
        genderTitle.text = "Gender".localized;
        
        //Dynamic Part
        genderLabel.text = "Male".localized;
        log.info("Dynamic Part not implemented");
        
        //Setting account sheet
        accountSheet = UIAlertController(title: "SureLogout".localized, message: nil, preferredStyle: .actionSheet);
        let logoutAction = UIAlertAction(title: "Logout".localized, style: .destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            self.logout();
        });
        let cancelActionForAccount = UIAlertAction(title: "Cancel".localized, style: .cancel, handler:nil);
        accountSheet.addAction(logoutAction);
        accountSheet.addAction(cancelActionForAccount);
        
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
        let cancelActionForGender = UIAlertAction(title: "Cancel".localized, style: .cancel, handler:nil);
        genderSheet.addAction(maleAction);
        genderSheet.addAction(femaleAction);
        genderSheet.addAction(cancelActionForGender);
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                self.present(accountSheet, animated: true, completion: nil);
            default:
                log.warning("Tap on a table row doesn't exist!");
            }
        } else {
            switch indexPath.row {
            case 0:
                self.present(genderSheet, animated:true, completion:nil);
            default:
                log.warning("Tap on a table row without response!");
            }
        }
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    func setGender(type: String!){
        //TODO:
        log.info("set gender request not implemented");
        if type == "male" {
            genderLabel.text = "Male".localized;
        } else if type == "female" {
            genderLabel.text = "Female".localized;
        }
    }
    
    func logout(){
        //TODO:
        log.info("log out request not implemented");
    }
}
