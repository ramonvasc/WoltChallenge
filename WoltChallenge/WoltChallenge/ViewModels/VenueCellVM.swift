//
//  VenueCellVM.swift
//  WoltChallenge
//
//  Created by Antônio Ramon Vasconcelos de Freitas on 16/09/19.
//  Copyright © 2019 Ramon. All rights reserved.
//

import Foundation

class VenueCellVM {

    private var coreDataManager: CoreDataManager
    private var venue: Venue

    init(coreDataManager: CoreDataManager, venue: Venue) {
        self.coreDataManager = coreDataManager
        self.venue = venue
    }

    func venueName() -> String {
        return venue.name
    }

    func venueDescription() -> String {
        return venue.venueDescription
    }

    func isFavorited() -> Bool {
        return venue.isFavorited
    }

    func venueImageUrl() -> String {
        return venue.imageUrl
    }

    func saveVenueFavorite(status: Bool) {
        venue.isFavorited = status
        coreDataManager.update(venue)
    }

}
