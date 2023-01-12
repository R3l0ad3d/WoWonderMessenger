
import UIKit
import MapKit
import CoreLocation

protocol HandleMapSearch: class {
    func dropPinZoomIn(placemark: MKPlacemark)
}

protocol GetUserDataAddress: AnyObject {
    func GetUserAddress(_ viewController: LocationSearchViewController,
                        latitude: Double,
                        longitutde: Double,
                        Address: String,
                        contrary: String)
}

class LocationSearchViewController: UIViewController {
    
    // MARK: - All IBOutlet's for this UIViewController
    @IBOutlet weak var loccationView: UIControl!
    @IBOutlet weak var getCurrentLocationButton: UIButton!
    
    //Variable's
    var selectedPin: MKPlacemark?
    var resultSearchController: UISearchController!
    let locationManager = CLLocationManager()
    var latitude = Double()
    var longitude = Double()
    var addressString = ""
    weak var delegate: GetUserDataAddress?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.startUpdatingLocation()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationList") as! LocationList
        self.resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        self.resultSearchController.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = self.resultSearchController?.searchBar
        self.resultSearchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        locationSearchTable.handleMapSearchDelegate = self
        navigationController?.navigationBar.isHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - All IBAction's for this UIViewController
    @IBAction func locationViewClick(_ sender: UIControl) {
        self.view.endEditing(true)
        self.getCurrentLocationData()
    }
    
    @IBAction func getCurrentLocationButtonClick(_ sender: UIButton) {
        self.view.endEditing(true)
        self.getCurrentLocationData()
    }
    
    //MARK:- Get Directions
    func getDirections(){
        guard let selectedPin = selectedPin else { return }
        let mapItem = MKMapItem(placemark: selectedPin)
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
    
    //MARK:- GetCurrentLocationData
    func getCurrentLocationData() {
        LocationManager.shared.getCurrentReverseGeoCodedLocation { (location:CLLocation?, placemark:CLPlacemark?, error:NSError?) in
            if let error = error {
                print("error =>\(error)")
                return
            }
            guard let location = location else { return }
            let currentlatitude = location.coordinate.latitude
            self.latitude = currentlatitude
            
            let currentlongitude = location.coordinate.longitude
            self.longitude = currentlongitude
            
            self.getAddressFromLatLon(pdblLatitude: currentlatitude , withLongitude: currentlongitude)
        }
    }
    
    //MARK:- getAddressFromLatLon
    private func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let latitude: Double = Double(pdblLatitude)
        let longitutde: Double = Double(pdblLongitude)
        let ceo: CLGeocoder = CLGeocoder()
        
        center.latitude = latitude
        center.longitude = longitutde
        
        let location: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        var addressString : String = ""
        
        ceo.reverseGeocodeLocation(location, completionHandler:
                                    {(placemarks, error) in
                                        if (error != nil ){
                                            print("reverse geodcode fail: \(error?.localizedDescription ?? "")")
                                        }
                                        let pm = placemarks! as [CLPlacemark]
                                        if pm.count > 0 {
                                            let pm = placemarks?[0]
                                            if pm?.subLocality != nil {
                                                addressString = addressString + (pm?.subLocality ?? "") + ", "
                                            }
                                            if pm?.thoroughfare != nil {
                                                addressString = addressString + (pm?.thoroughfare ?? "") + ", "
                                            }
                                            if pm?.locality != nil {
                                                addressString = addressString + (pm?.locality ?? "") + ", "
                                            }
                                            if pm?.country != nil {
                                                addressString = addressString + (pm?.country ?? "")
                                            }
                                            self.delegate?.GetUserAddress(self, latitude: self.latitude, longitutde: self.longitude, Address: addressString, contrary: pm?.country ?? "" )
                                            self.navigationController?.popViewController(animated: true)
                                        }
                                    })
    }
}

//MARK:- CLLocationManagerDelegate
extension LocationSearchViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            print("location:: (location)")
        }
    }
}

//MARK:- HandleMapSearch
extension LocationSearchViewController: HandleMapSearch {
    
    func dropPinZoomIn(placemark: MKPlacemark) {
        
        var addressString : String = ""
        
        if placemark.subLocality != nil {
            addressString = addressString + (placemark.subLocality ?? "") + ", "
        }
        if placemark.thoroughfare != nil {
            addressString = addressString + (placemark.thoroughfare ?? "") + ", "
        }
        if placemark.locality != nil {
            addressString = addressString + (placemark.locality ?? "") + ", "
        }
        if placemark.country != nil {
            addressString = addressString + (placemark.country ?? "") + ", "
        }
        if placemark.postalCode != nil {
            addressString = addressString + (placemark.postalCode ?? "")
        }
        
        let latitude = placemark.coordinate.latitude
        self.latitude = latitude
        
        let longitude = placemark.coordinate.longitude
        self.longitude = longitude
        
        self.delegate?.GetUserAddress(self, latitude: latitude, longitutde: longitude, Address: addressString, contrary: placemark.country ?? "")
        self.navigationController?.popViewController(animated: true)
    }
}

