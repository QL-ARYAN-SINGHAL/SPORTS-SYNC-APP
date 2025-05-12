import SwiftUI
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var lastKnownLocation: CLLocationCoordinate2D?
    
    // Variables
    private var locationCompletion: ((String?) -> Void)?
    private var manager: CLLocationManager = CLLocationManager()

    // Initializer
    override init() {
        super.init()
        manager.delegate = self // Delegate here makes the manager keep a record of change or update in location
    }
    
    func requestState(completion: @escaping (String?) -> Void) { // Request for location as City
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
        
        // Call to reverse geocoder to fetch city
        reverseGeocoding(location: location) { [weak self] city in
            self?.locationCompletion?(city)
            self?.locationCompletion = nil
        }
    }

    // Reverse Geocoder to fetch city from lat,lon
    private func reverseGeocoding(location: CLLocation, completion: @escaping (String?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let city = placemarks?.first?.locality {
                completion(city) // Return city name
            } else {
                completion(nil) // Return nil if city is not found
            }
        }
    }
}
