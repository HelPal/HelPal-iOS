//
//  MapViewController.swift
//  HelPal
//
//  Created by Dian Zhong on 11/03/2017.
//  Copyright © 2017 CodeAsO. All rights reserved.
//

import UIKit
import Mapbox

class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MGLMapView!
    
    override func viewDidLoad() {
        let styleURL = NSURL(string: "mapbox://styles/zhongdian121/cj058qnqq00452rofi3lt79m6");
        mapView.styleURL = styleURL as URL!;
        mapView.reloadStyle(self);
        mapView.setCenter(CLLocationCoordinate2D(latitude: 39.9710176, longitude: 116.3119063), zoomLevel: 14, animated: true);
    }
}
