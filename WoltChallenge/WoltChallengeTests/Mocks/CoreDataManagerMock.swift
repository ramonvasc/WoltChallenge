//
//  CoreDataManagerMock.swift
//  WoltChallengeTests
//
//  Created by Antônio Ramon Vasconcelos de Freitas on 17/09/19.
//  Copyright © 2019 Ramon. All rights reserved.
//

import XCTest
@testable import WoltChallenge

class CoreDataManagerMock: CoreDataManageable {

    var venue: Venue?

    func createData(for venue: Venue) {
        self.venue = venue
    }

    func retrieveVenue(id: String) -> Venue? {
        if venue?.venueId == id {
            return venue
        }
        return nil
    }

    func update(_ venue: Venue) {
        self.venue = venue
    }

}
