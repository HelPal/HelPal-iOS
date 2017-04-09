
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
    
    @IBOutlet weak var logoImage: SpringImageView!
    
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var btnView: SpringView!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var btnLabel: UILabel!
    @IBOutlet weak var switchBtn: UIButton!
    
    var isLogIn = true; //false for signup
    
    override func viewDidLoad() {
        //Cancel Btn on the Nav Bar
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissLognSignVC));
        self.navigationItem.leftBarButtonItem = cancelBtn;
        
        //Setting UI
        initInputView(view: usernameView);
        initInputView(view: passwordView);
        initInputView(view: btnView);
        
        btnLabel.text = "Login".localized;
        switchBtn.setTitle("Signup".localized, for: .normal);
        
        usernameField.placeholder = "Username".localized;
        passwordField.placeholder = "Password".localized;
        
        logoImage.animation = "slideRight";
        logoImage.delay = 0.5;
        logoImage.animate();
        
        btnView.backgroundColor = UIColor(red: 82, green: 190, blue: 248);
        btnView.layer.borderColor = UIColor.clear.cgColor;
        btnView.isUserInteractionEnabled = true;
        let tapBtnRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapBtn));
        btnView.addGestureRecognizer(tapBtnRecognizer);
    }
    
    @IBAction func tapSwitch(_ sender: Any) {
        if isLogIn == true {
            btnLabel.text = "Signup".localized;
            switchBtn.setTitle("Login".localized, for: .normal);
            isLogIn = false;
        } else{
            btnLabel.text = "Login".localized;
            switchBtn.setTitle("Signup".localized, for: .normal);
            isLogIn = true;
        }
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
    
    func tapBtn(){
        if isLogIn == true{
            login();
        } else {
            signup();
        }
        
        //TODO: move this to error handler
        btnView.animation = "shake";
        btnView.backgroundColor = UIColor(red: 245, green: 130, blue: 125);
        btnView.animate();
        delay(delay: 0.5, closure: {() -> Void in
            self.btnView.backgroundColor = UIColor(red: 82, green: 190, blue: 248);
        });
    }
    
    func login(){
        log.info("not implemented");
    }
    
    func signup(){
        log.info("not implemented");
    }
}
