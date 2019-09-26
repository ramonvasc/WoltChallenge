//
//  VenueCellVM.swift
//  WoltChallenge
//
//  Created by Antônio Ramon Vasconcelos de Freitas on 16/09/19.
//  Copyright © 2019 Ramon. All rights reserved.
//

import Foundation

class VenueCellVM {

    private var venue: Venue

    init(venue: Venue) {
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

    func setFavorited(status: Bool) {
        venue.isFavorited = status
    }

}
