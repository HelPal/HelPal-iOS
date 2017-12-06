//
//  EmptyChatlistContainedController.swift
//  HelPal
//
//  Created by Dian Zhong on 11/03/2017.
//  Copyright © 2017 CodeAsO. All rights reserved.
//

import UIKit

class EmptyChatlistContainedController: UIViewController {
    
    @IBOutlet weak var image404: UIImageView!
    @IBOutlet weak var message: UILabel!
    
    var isLoggedIn: Bool = false;
    var tapper1: UITapGestureRecognizer!;
    var tapper2: UITapGestureRecognizer!;
    
    override func viewDidLoad() {
        //Check whether is logged in
        isLoggedIn = UserLifeCycle.isLoggedIn();
        if isLoggedIn {
            message.text = "EmptyChatlistMessage_NoMessage".localized;}
        else{
            message.text = "EmptyChatlistMessage_NotLoggin".localized;}
        
        //A UIGestureRecognizer is to be used with a single view. That UIGestureRecognizer has a single view property gives it away.
        tapper1 = UITapGestureRecognizer(target: self, action: #selector(pushUpLoginView));
        tapper2 = UITapGestureRecognizer(target: self, action: #selector(pushUpLoginView));
        
        if isLoggedIn == false {
            image404.isUserInteractionEnabled = true;
            message.isUserInteractionEnabled = true;
            image404.addGestureRecognizer(tapper1);
            message.addGestureRecognizer(tapper2);
        }
    }
    
    @objc func pushUpLoginView() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "lognSignNav");
        self.present(vc!, animated: true, completion: nil);
    }
}
