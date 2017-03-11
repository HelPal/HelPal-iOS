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
    override func viewDidLoad() {
        let segment: UISegmentedControl = UISegmentedControl(items: ["RecommonSegementedTitle1".localized, "RecommonSegementedTitle2".localized])
        segment.sizeToFit()
        segment.tintColor = UIColor(red:0.99, green:0.00, blue:0.25, alpha:1.00)
        segment.selectedSegmentIndex = 0;
        self.navigationItem.titleView = segment
    }
}
