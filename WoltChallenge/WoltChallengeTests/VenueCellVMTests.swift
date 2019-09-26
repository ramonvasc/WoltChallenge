//
//  VenueCellVMTests.swift
//  WoltChallengeTests
//
//  Created by Antônio Ramon Vasconcelos de Freitas on 17/09/19.
//  Copyright © 2019 Ramon. All rights reserved.
//

import XCTest
@testable import WoltChallenge

class VenueCellVMTests: XCTestCase {

    func testVenueName() {
        let vm = aVM()
        let expectedName = "Nakama"
        XCTAssertEqual(vm.venueName(), expectedName)
    }

    func testVenueDescription() {
        let vm = aVM()
        let expectedDescription = "Unique Japanese flavors that will excite you!"
        XCTAssertEqual(vm.venueDescription(), expectedDescription)
    }

    func testIsFavorited() {
        let vm = aVM()
        let expectedIsFavorited = false
        XCTAssertEqual(vm.isFavorited(), expectedIsFavorited)
    }

    func testVenueImageUrl() {
        let vm = aVM()
        let expectedUrl = "https://prod-wolt-venue-images-cdn.wolt.com/5d4a8325d47d249f002eb222/8d265e29ba4f8d590a86ca6bc960fe68"
        XCTAssertEqual(vm.venueImageUrl(), expectedUrl)
    }

    func testSetFavorited() {
        let vm = aVM()
        let expectedIsFavorite = true
        vm.setFavorited(status: true)

        XCTAssertEqual(vm.isFavorited(), expectedIsFavorite)
    }

    func aVM() -> (VenueCellVM) {
        guard let venue = getVenues().first else {
            XCTFail("Venues mock json is wrong")
            fatalError()
        }
        let vm = VenueCellVM(venue: venue)

        return vm
    }

}
