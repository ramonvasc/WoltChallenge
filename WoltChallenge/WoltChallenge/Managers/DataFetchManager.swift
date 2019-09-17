//
//  DataFetchManager.swift
//  WoltChallenge
//
//  Created by Antônio Ramon Vasconcelos de Freitas on 16/09/19.
//  Copyright © 2019 Ramon. All rights reserved.
//

import Foundation

enum AppError: Error {
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
}

enum Result<T> {
    case success(T)
    case failure(AppError)
}

struct Coordinate {
    var latitude: String
    var longitude: String
}

class DataFetchManager {

    func fetch(at location: Coordinate, completion: @escaping (Result<[Venue]>) -> Void) {
        var urlComponents = URLComponents(string: "https://restaurant-api.wolt.fi/v3/venues")
        let session = URLSession.shared
        urlComponents?.queryItems = [
            URLQueryItem(name: "lat", value: location.latitude),
            URLQueryItem(name: "lon", value: location.longitude)
        ]

        guard let url = urlComponents?.url else {
            return
        }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request, completionHandler: { data, response, error in

            guard error == nil else {
                completion(Result.failure(AppError.networkError(error!)))
                return
            }

            guard let data = data else {
                completion(Result.failure(AppError.dataNotFound))
                return
            }

            
            do {
                //create decodable object from data
                let results = try JSONDecoder().decode(Results.self, from: data)
                //get only the first 15 elements
                let venues = Array(results.venues.prefix(15))
                completion(Result.success(venues))
            } catch let error {
                completion(Result.failure(AppError.jsonParsingError(error as! DecodingError)))
            }
        })

        task.resume()
    }

}
