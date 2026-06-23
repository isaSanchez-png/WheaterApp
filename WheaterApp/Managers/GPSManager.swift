//
//  GPSManager.swift
//  WheaterApp
//
//  Created by Isa on 23/06/26.
//
import Foundation
import CoreLocation
internal import Combine
import MapKit

class GPSManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    private let manager = CLLocationManager()
    
    @Published var latitude: Double? = nil
    @Published var longitude: Double? = nil
    @Published var currentCityName: String? = nil
    
    override init () {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            DispatchQueue.main.async{
                self.latitude = lastLocation.coordinate.latitude
                self.longitude = lastLocation.coordinate.longitude
            }
            
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(lastLocation){placemarks, error in
            if let errr = error {
                print("Error: \(errr.localizedDescription)")
                return
            }
            if let placemark = placemarks?.first {
                DispatchQueue.main.async {
                    self.currentCityName = placemark.locality
                }
            }
        }
            manager.stopUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error GPS: \(error.localizedDescription)")
    }
}
