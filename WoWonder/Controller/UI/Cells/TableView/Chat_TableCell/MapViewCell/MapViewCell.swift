//
//  MapViewCell.swift
//  WoWonder
//
//  Created by UnikaApp on 12/10/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewCell: UITableViewCell {

    @IBOutlet weak var mapViewCellView: UIControl!
    @IBOutlet weak var mapMainVew: GMSMapView!
    @IBOutlet weak var Timelabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    
    //Variable's
    var lat = Double()
    var long = Double()
    private var locationManager = CLLocationManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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

//MARK: - CLLocationManagerDelegate Method's
extension MapViewCell:  CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 10)
        self.mapMainVew.isMyLocationEnabled = true
        self.mapMainVew.camera = camera
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(lat, long)
        marker.map = self.mapMainVew
    }
}

