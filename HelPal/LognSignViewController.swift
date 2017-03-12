
//
//  LognSignViewController.swift
//  HelPal
//
//  Created by zhongdian on 2017/3/2.
//  Copyright © 2017年 CodeAsO. All rights reserved.
//

import UIKit
import Spring

//This VC shows the log in and the sign up parts
class LognSignViewController: UIViewController {
    
    @IBOutlet weak var logoImage: SpringImageView!
    
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var btnView: SpringView!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var btnLabel: UILabel!
    @IBOutlet weak var switchBtn: UIButton!
    
    override func viewDidLoad() {
        //Cancel Btn on the Nav Bar
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissLognSignVC));
        self.navigationItem.leftBarButtonItem = cancelBtn;
        
        //Setting UI
        initInputView(view: usernameView);
        initInputView(view: passwordView);
        initInputView(view: btnView);
        btnView.backgroundColor = UIColor(red: 82, green: 190, blue: 248);
        btnView.layer.borderColor = UIColor.clear.cgColor;
        btnView.isUserInteractionEnabled = true;
        btnView.animation = "slideRight";
        btnView.animate();
    }
    
    @IBAction func tapSwitch(_ sender: Any) {
    }
    
    func initInputView(view: UIView){
        view.layer.borderWidth = 1.0;
        view.layer.borderColor = UIColor(pureHex: 0xdddddd).cgColor;
        view.layer.cornerRadius = 4.0;
        view.layer.masksToBounds = true;
        view.backgroundColor = UIColor(pureHex: 0xffffff);
    }

    //TODO: test whether this is avaiable when next VC traggles this.
    func dismissLognSignVC(){
        self.dismiss(animated: true, completion: nil);
    }
}
