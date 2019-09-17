//
//  Venue.swift
//  WoltChallenge
//
//  Created by Antônio Ramon Vasconcelos de Freitas on 16/09/19.
//  Copyright © 2019 Ramon. All rights reserved.
//

import Foundation
import CoreData

struct Venue: Codable {

    let venueId: String
    let name: String
    let venueDescription: String
    let imageUrl: String
    var isFavorited: Bool

    private enum CodingKeys: String, CodingKey {
        case venueId = "id"
        case venueDescription = "short_description"
        case imageUrl = "listimage"
        case name
    }

    private enum IdKeys: String, CodingKey {
        case oid = "$oid"
    }

    private enum NameKeys: String, CodingKey {
        case value
    }

    private enum VenueDescriptionKeys: String, CodingKey {
        case value
    }

    init(managedVenue: NSManagedObject) {
        venueId = managedVenue.value(forKey: "venueId") as! String
        name = managedVenue.value(forKey: "name") as! String
        venueDescription = managedVenue.value(forKey: "venueDescription") as! String
        imageUrl = managedVenue.value(forKey: "imageUrl") as! String
        isFavorited = managedVenue.value(forKey: "isFavorited") as! Bool
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        isFavorited = false
        imageUrl = try container.decode(String.self, forKey: .imageUrl)

        // Decoding strategy for Id
        let response = try container.nestedContainer(keyedBy: IdKeys.self, forKey: .venueId)
        venueId = try response.decode(String.self, forKey: .oid)

        // Decoding strategy for Name
        var namesUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .name)
        var namesArray = [String]()

        while !namesUnkeyedContainer.isAtEnd {
            let nameContainer = try namesUnkeyedContainer.nestedContainer(keyedBy: NameKeys.self)
            namesArray.append(try nameContainer.decode(String.self, forKey: .value))
        }

        guard let firstName = namesArray.first else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath + [CodingKeys.name], debugDescription: "names cannot be empty"))
        }
        self.name = firstName


        // Decoding strategy for Venue Description
        var descriptionUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .venueDescription)
        var descriptionsArray = [String]()

        while !descriptionUnkeyedContainer.isAtEnd {
            let descriptionContainer = try descriptionUnkeyedContainer.nestedContainer(keyedBy: VenueDescriptionKeys.self)
            descriptionsArray.append(try descriptionContainer.decode(String.self, forKey: .value))
        }

        guard let firstDescription = descriptionsArray.first else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath + [CodingKeys.venueDescription], debugDescription: "description cannot be empty"))
        }
        self.venueDescription = firstDescription
    }
}
