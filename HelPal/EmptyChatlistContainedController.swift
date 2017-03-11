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
    var tapper: UITapGestureRecognizer!;
    
    override func viewDidLoad() {
        //TODO: Check whether is logged in
        //if yes
        //isLoggedIn = true;
        //message.text = "EmptyChatlistMessage_NoMessage".localized;
        //if not
        message.text = "EmptyChatlistMessage_NotLoggin".localized;
        
        tapper = UITapGestureRecognizer(target: self, action: #selector(pushUpLoginView));
        
        if isLoggedIn == false {
            image404.isUserInteractionEnabled = true;
            message.isUserInteractionEnabled = true;
            image404.addGestureRecognizer(tapper);
            message.addGestureRecognizer(tapper);
        }
    }
    
    func pushUpLoginView() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "lognSignNav");
        self.present(vc!, animated: true, completion: nil);
    }
}
