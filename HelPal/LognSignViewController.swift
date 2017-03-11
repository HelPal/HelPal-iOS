
//
//  LognSignViewController.swift
//  HelPal
//
//  Created by zhongdian on 2017/3/2.
//  Copyright © 2017年 CodeAsO. All rights reserved.
//

import UIKit

//This VC shows the log in and the sign up parts
class LognSignViewController: UIViewController {
    override func viewDidLoad() {
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissLognSignVC));
        self.navigationItem.leftBarButtonItem = cancelBtn;
    }
    
    //TODO: test whether this is avaiable when next VC traggles this.
    func dismissLognSignVC(){
        self.dismiss(animated: true, completion: nil);
    }
}
