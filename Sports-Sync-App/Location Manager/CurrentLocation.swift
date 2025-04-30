//
//  CurrentLocation.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 30/04/25.
//


//MARK: Responsibilities: - Fetch user location latitude and longitude through CLLOcation , use that fetched lat , lon as argument in reverse geocoder that will convert the lat,lon to the address(particularly we want State).
import Foundation
import CoreLocation

//final keyword --> prevents anyone to make an extension or inherit another from this class, this is particularly used when u dont watn to change the data from another part of code and keep data secure.


final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
         @Published var lastKnownLocation: CLLocationCoordinate2D?
    
    //Variables
         private var locationCompletion: ((String?) -> Void)?
         private var manager: CLLocationManager = CLLocationManager()

//    Initialiser
    override init() {
        super.init()
        manager.delegate = self //deleagte here makes the manager to keep a record of change or update in location
    }
    
    func requestState(completion: @escaping (String?) -> Void) { //request for location as State
                locationCompletion = completion
                checkLocationAuthorization()
    }
    
    private func checkLocationAuthorization() {
        
        switch manager.authorizationStatus {
            
              case .notDetermined:
                                  manager.requestWhenInUseAuthorization()
                                  print("User not determined here")
              case .restricted, .denied:
                                  print("Location access denied or restricted")
                                  locationCompletion?(nil)
              case .authorizedWhenInUse, .authorizedAlways:
                                  manager.startUpdatingLocation()
              @unknown default:
                                  locationCompletion?(nil)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
                       checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                     manager.stopUpdatingLocation()
        
                     guard let location = locations.first else {
                     locationCompletion?(nil)
                       return
        }
        
                     lastKnownLocation = location.coordinate
        
        //call to revser geocoder to fetch state
                     reverseGeocoding(location: location) { [weak self] state in
                     self?.locationCompletion?(state)
                     self?.locationCompletion = nil
        }
    }

    //Reverse Geocoder to fetch address from lat,lon
    private func reverseGeocoding(location: CLLocation, completion: @escaping (String?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let state = placemarks?.first?.administrativeArea {
                completion(state)
            } else {
                completion(nil)
            }
        }
    }
}
