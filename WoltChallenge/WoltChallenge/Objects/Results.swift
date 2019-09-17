//
//  Results.swift
//  WoltChallenge
//
//  Created by Antônio Ramon Vasconcelos de Freitas on 16/09/19.
//  Copyright © 2019 Ramon. All rights reserved.
//

import Foundation

struct Results: Codable {

    let venues: [Venue]

    private enum CodingKeys: String, CodingKey {
        case venues = "results"
    }

}
