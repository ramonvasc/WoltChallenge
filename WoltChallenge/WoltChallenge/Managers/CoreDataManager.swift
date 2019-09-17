//
//  CoreDataManager.swift
//  WoltChallenge
//
//  Created by Antônio Ramon Vasconcelos de Freitas on 16/09/19.
//  Copyright © 2019 Ramon. All rights reserved.
//

import CoreData
import UIKit

protocol CoreDataManageable {
    func createData(for venue: Venue)
    func retrieveVenue(id: String) -> Venue?
    func update(_ venue: Venue)
}

class CoreDataManager: CoreDataManageable {

    func createData(for venue: Venue) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let venueEntity = NSEntityDescription.entity(forEntityName: "ManagedVenue", in: managedContext)!

        let managedVenue = NSManagedObject(entity: venueEntity, insertInto: managedContext)
        managedVenue.setValue(venue.venueId, forKey: "venueId")
        managedVenue.setValue(venue.name, forKey: "name")
        managedVenue.setValue(venue.venueDescription, forKey: "venueDescription")
        managedVenue.setValue(venue.imageUrl, forKey: "imageUrl")
        managedVenue.setValue(venue.isFavorited, forKey: "isFavorited")

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func retrieveVenue(id: String) -> Venue? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedVenue")
        
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "venueId = %@", id)
        
        do {
            if let result = try (managedContext.fetch(fetchRequest) as? [NSManagedObject])?.first {
                let venue = Venue(managedVenue: result)
                return venue
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return nil
    }

    func update(_ venue: Venue) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ManagedVenue")
        fetchRequest.predicate = NSPredicate(format: "venueId = %@", venue.venueId)

        do {
            if let managedVenue = try managedContext.fetch(fetchRequest).first as? NSManagedObject {
                managedVenue.setValue(venue.isFavorited, forKey: "isFavorited")
            } else {
                createData(for: venue)
                return
            }

            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }

        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }
}
