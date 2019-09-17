//
//  VenueVM.swift
//  WoltChallenge
//
//  Created by Antônio Ramon Vasconcelos de Freitas on 16/09/19.
//  Copyright © 2019 Ramon. All rights reserved.
//

import Foundation
import CoreLocation

protocol VenuesFetchDelegate: class {
    func didFetchResults()
    func didFailToFetchResults()
}

class VenueVM: NSObject {

    private var dataFetchManager: DataFetchManageable
    private var coreDataManager: CoreDataManageable
    private var locationManager: CLLocationManager
    private var currentLocation = 0
    private var locations: [Coordinate] = [
        Coordinate(latitude: "60.170187", longitude: "24.930599"),
        Coordinate(latitude: "60.169418", longitude: "24.931618"),
        Coordinate(latitude: "60.169818", longitude: "24.932906"),
        Coordinate(latitude: "60.170005", longitude: "24.935105"),
        Coordinate(latitude: "60.169108", longitude: "24.936210"),
        Coordinate(latitude: "60.168355", longitude: "24.934869"),
        Coordinate(latitude: "60.167560", longitude: "24.932562"),
        Coordinate(latitude: "60.168254", longitude: "24.931532"),
        Coordinate(latitude: "60.169012", longitude: "24.930341"),
        Coordinate(latitude: "60.170085", longitude: "24.929569")
    ]

    var venues: [Venue] = [Venue]()
    weak var delegate: VenuesFetchDelegate?

    init(dataFetchManager: DataFetchManageable, coreDataManager: CoreDataManageable, locationManager: CLLocationManager = CLLocationManager()) {
        self.dataFetchManager = dataFetchManager
        self.coreDataManager = coreDataManager
        self.locationManager = locationManager
        super.init()
        _ = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(setupLocationManager), userInfo: nil, repeats: true)

    }

    func fetchVenues() {
        dataFetchManager.fetch(at: locations[currentLocation]) { [weak self] result in
            switch result {
            case .success(let venues):
                DispatchQueue.main.async {
                    self?.venues = venues
                    for (index,venue) in venues.enumerated() {
                        if let storedVenue = self?.coreDataManager.retrieveVenue(id: venue.venueId) {
                            self?.venues[index].isFavorited = storedVenue.isFavorited
                        }
                    }
                    self?.delegate?.didFetchResults()
                }
            case .failure(_):
                self?.delegate?.didFailToFetchResults()
            }
        }
        currentLocation = currentLocation >= 9 ? 0 : currentLocation + 1
    }

    @objc func setupLocationManager() {
        //keep the app refreshing the venues even when the app goes to background
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension VenueVM: CLLocationManagerDelegate { //this delegate requires NSObject

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        fetchVenues()
    }

}
