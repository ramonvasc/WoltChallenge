//
//  CoreDataManagerTests.swift
//  WoltChallengeTests
//
//  Created by Antônio Ramon Vasconcelos de Freitas on 17/09/19.
//  Copyright © 2019 Ramon. All rights reserved.
//

import XCTest
@testable import WoltChallenge

class CoreDataManagerTests: XCTestCase {

    func testCreateData() {
        let manager = aManager()
        guard let venue = getVenues().first else {
            XCTFail("Venues mock json is wrong")
            return
        }
        manager.createData(for: venue)

        guard let retrievedVenue = manager.retrieveVenue(id: venue.venueId) else {
            XCTFail("Could not retrieve data from CoreData")
            return
        }

        XCTAssertEqual(venue, retrievedVenue)
    }

    func testUpdate() {
        let manager = aManager()
        guard let venue = getVenues().first, let expectedVenue =  getVenues().last else {
            XCTFail("Venues mock json is wrong")
            return
        }
        manager.createData(for: venue)

        guard let retrievedVenue = manager.retrieveVenue(id: venue.venueId) else {
            XCTFail("Could not retrieve data from CoreData")
            return
        }

        XCTAssertEqual(venue, retrievedVenue)

        manager.update(expectedVenue)

        guard let retrievedUpdatedVenue = manager.retrieveVenue(id: expectedVenue.venueId) else {
            XCTFail("Could not retrieve data from CoreData")
            return
        }

        XCTAssertEqual(expectedVenue, retrievedUpdatedVenue)
    }

    func aManager() -> CoreDataManager {
        let coreDataManager = CoreDataManager()
        return coreDataManager
    }
}
