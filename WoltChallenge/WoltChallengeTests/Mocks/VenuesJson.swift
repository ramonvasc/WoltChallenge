//
//  VenuesJson.swift
//  WoltChallengeTests
//
//  Created by Antônio Ramon Vasconcelos de Freitas on 17/09/19.
//  Copyright © 2019 Ramon. All rights reserved.
//

import XCTest
@testable import WoltChallenge

let venuesJson = """
{
    "results": [{
            "listimage": "https://prod-wolt-venue-images-cdn.wolt.com/5d4a8325d47d249f002eb222/8d265e29ba4f8d590a86ca6bc960fe68",
            "short_description": [{
                "lang": "en",
                "value": "Unique Japanese flavors that will excite you!"
            }],
            "name": [{
                "lang": "en",
                "value": "Nakama"
            }],
            "id": {
                "$oid": "5d106a7c305a627b58fc4e72"
            }
        },
        {
            "listimage": "https://prod-wolt-venue-images-cdn.wolt.com/5d38a3b9b77d3e7fa130815e/dd6d9bd617b67d8d1008b66cb8ded61d",
            "short_description": [{
                "lang": "en",
                "value": "Unique ice cream flavors and delicious desserts with quality ingredients!"
            }],
            "name": [{
                "lang": "en",
                "value": "Zuccherino"
            }],
            "id": {
                "$oid": "5d38a3b9b77d3e7fa130815e"
            }
        }
    ],
    "status": "OK"
}
""".data(using: .utf8)!

func getVenues() -> [Venue] {
    do {
        let results = try JSONDecoder().decode(Results.self, from: venuesJson)
        return results.venues
    } catch {
        XCTFail("Venues mock json is wrong")
        return [Venue]()
    }
}
