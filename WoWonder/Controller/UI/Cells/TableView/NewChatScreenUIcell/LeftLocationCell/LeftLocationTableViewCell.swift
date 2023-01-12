//
//  LeftLocationTableViewCell.swift
//  WoWonder
//
//  Created by Mac on 11/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import GoogleMaps

class LeftLocationTableViewCell: UITableViewCell {

    @IBOutlet weak var googleMapView: GMSMapView!
    @IBOutlet weak var messageVIew: UIControl!
    @IBOutlet weak var profileImageview: UIImageView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var messageTim: UILabel!
    @IBOutlet weak var starImageVIew: UIImageView!
    
    //Variable's
    var lat = Double()
    var long = Double()
    private var locationManager = CLLocationManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.messageVIew.clipsToBounds = true
        self.messageVIew.layer.cornerRadius = 12
        self.messageVIew.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
    }

    func callDelegateMethod() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
    }
}

extension LeftLocationTableViewCell:  CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 10)
        self.googleMapView.isMyLocationEnabled = true
        self.googleMapView.camera = camera
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(lat, long)
        marker.map = self.googleMapView
    }
}

