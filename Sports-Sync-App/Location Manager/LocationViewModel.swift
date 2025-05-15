//
//  LocationViewModel.swift
//  Sports-Sync-App
//
//  Created by ARYAN SINGHAL on 13/05/25.
//
//MARK: - RESPONSIBILITY - FETCH THE LOCATION DETAILS FROM LOCATION MANAGER TO DISPLAY THE LOCATION ON UI
import SwiftUI

class LocationViewModel: ObservableObject {
    @Published var currentLocation: String = "Fetching..."
    @Published var showLocationPermissionAlert: Bool = false

    private var locationManager = LocationManager()

    init() {
        requestLocationPermission()
    }

    func requestLocationPermission() {
        locationManager.requestLocation { [weak self] location in
                if let location = location {
                    self?.currentLocation = location
                } else {
                    self?.currentLocation = "Location Not Available"
                }
        }
    }

    func handleLocationTap() {
        if currentLocation == "Fetching..." || currentLocation == "Location Not Available" {
            showLocationPermissionAlert = true
        } else {
            requestLocationPermission()
        }
    }
}
