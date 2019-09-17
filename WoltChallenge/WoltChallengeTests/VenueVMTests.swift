//
//  VenueVMTests.swift
//  WoltChallengeTests
//
//  Created by Antônio Ramon Vasconcelos de Freitas on 17/09/19.
//  Copyright © 2019 Ramon. All rights reserved.
//

import XCTest
@testable import WoltChallenge

class VenueVMTests: XCTestCase {

    func testSuccessFetchVenues() {
        let (vm, dataFetchManagerMock) = aVM()
        let expectedVenues = getVenues()
        dataFetchManagerMock.result = Result.success(expectedVenues)
        vm.fetchVenues()

        XCTAssertEqual(dataFetchManagerMock.venues, expectedVenues)
    }

    func testFailFetchVenues() {
        let (vm, dataFetchManagerMock) = aVM()
        let expectedVenues = [Venue]()
        dataFetchManagerMock.result = Result.failure(.dataNotFound)
        vm.fetchVenues()

        XCTAssertEqual(dataFetchManagerMock.venues, expectedVenues)
    }

    func aVM() -> (VenueVM, DataFetchManagerMock) {
        let dataFetchManagerMock = DataFetchManagerMock()
        let coreDataManagerMock = CoreDataManagerMock()
        let vm = VenueVM(dataFetchManager: dataFetchManagerMock, coreDataManager: coreDataManagerMock)

        return (vm, dataFetchManagerMock)
    }
}
