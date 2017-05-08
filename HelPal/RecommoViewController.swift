//
//  RecommoViewController.swift
//  HelPal
//
//  Created by zhongdian on 2017/3/2.
//  Copyright © 2017年 CodeAsO. All rights reserved.
//

import UIKit

//This view controller shows recommendations from the server
//There will be a segmented control on the navi bar, to switch map mode and the list mode
//Mapbox will do the help
class RecommonViewController: UIViewController{
    
    @IBOutlet weak var listContainer: UIView! //segment 1
    @IBOutlet weak var mapContainer: UIView! //segment 0
    
    override func viewDidLoad() {
        
        //Hide list container by default
        listContainer.isHidden = true;
        
        //Adding the segment
        let segment: UISegmentedControl = UISegmentedControl(items: ["RecommonSegementedTitle1".localized, "RecommonSegementedTitle2".localized]);
        segment.sizeToFit();
        segment.tintColor = UIColor(red:0.99, green:0.00, blue:0.25, alpha:1.00);
        segment.selectedSegmentIndex = 0;
        self.navigationItem.titleView = segment;
        //Swift 3 has changed the way to write addTarget Method
        segment.addTarget(self, action: #selector(segmentChanged(sender:)), for: .valueChanged);
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(tapSearchBtn));
    }
    
    func segmentChanged(sender: UISegmentedControl){
        if(sender.selectedSegmentIndex == 1){
            listContainer.isHidden = true;
            mapContainer.isHidden = false;
        }else if(sender.selectedSegmentIndex == 0){
            listContainer.isHidden = false;
            mapContainer.isHidden = true;
        }
    }
    
    func tapSearchBtn(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "searchNav");
        self.present(vc!, animated: true, completion: nil);
    }
    
}
