//
//  DataFetchManagerTests.swift
//  WoltChallengeTests
//
//  Created by Antônio Ramon Vasconcelos de Freitas on 17/09/19.
//  Copyright © 2019 Ramon. All rights reserved.
//

import XCTest
@testable import WoltChallenge

class DataFetchManagerTests: XCTestCase {

    func testSuccessFetch() {
        let manager = aManager()
        let coordinate = Coordinate(latitude: "60.170187", longitude: "24.930599")
        let exp = self.expectation(description: "Waiting for backend response")
        manager.fetch(at: coordinate) { result in
            switch result {
            case .success(let venues):
                XCTAssertEqual(venues.count, 15)
            case .failure(_):
                XCTFail("Backend should return valid data for these coordinates")
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
        }
    }

    func testFailFetch() {
        let manager = aManager()
        let coordinate = Coordinate(latitude: "10000", longitude: "10000")
        let exp = self.expectation(description: "Waiting for backend response")
        manager.fetch(at: coordinate) { result in
            switch result {
            case .success(_):
                XCTFail("Backend should return in valid data for these coordinates")
            case .failure(let error):
                XCTAssertNotNil(error, "The coordinates should return invalid results")
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
        }
    }

    func aManager() -> DataFetchManager {
        let dataFetchManager = DataFetchManager()
        return dataFetchManager
    }
}
