import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate,ObservableObject {
    private var locationManager = CLLocationManager()
    var locationCompletion: ((String?) -> Void)?

    override init() {
        super.init()
        locationManager.delegate = self
    }

    //escaping closures are used to pass a closure that will be called later outside the function scopeee
    
    func requestLocation(completion: @escaping (String?) -> Void) {
        locationCompletion = completion
        checkLocationAuthorization()
    }

    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            locationCompletion?(nil)
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
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

        reverseGeocodeLocation(location)
    }

    private func reverseGeocodeLocation(_ location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            if let city = placemarks?.first?.locality {
                self?.locationCompletion?(city)
            } else {
                self?.locationCompletion?(nil)
            }
        }
    }
}
