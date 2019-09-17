//
//  DataFetchManagerMock.swift
//  WoltChallengeTests
//
//  Created by Antônio Ramon Vasconcelos de Freitas on 17/09/19.
//  Copyright © 2019 Ramon. All rights reserved.
//

import XCTest
@testable import WoltChallenge

class DataFetchManagerMock: DataFetchManageable {

    var result = Result<[Venue]>.failure(.dataNotFound)
    var venues = [Venue]()

    func fetch(at location: Coordinate, completion: @escaping (Result<[Venue]>) -> Void) {

        switch result {
        case .success(let venues):
            self.venues = venues
            completion(Result.success(venues))
        case .failure(_):
            self.venues = [Venue]()
            completion(Result.failure(.dataNotFound))
        }
    }

}
