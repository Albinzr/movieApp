//
//  CoreDataManager.swift
//  movie
//
//  Created by Albin on 02/08/16.
//  Copyright © 2016 Albin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager{
    // MARK :- managedObjectContext -
    
    func managedObjectContext() -> NSManagedObjectContext{
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.managedObjectContext
        
    }
    
    // MARK: - Retrive data -
    
    func fetchObjectsFromEntity(entityName: String, predicate: NSPredicate?, sortDes: NSSortDescriptor?) -> [AnyObject] {
        
        let moc: NSManagedObjectContext = managedObjectContext()
        let entityDescription: NSEntityDescription = NSEntityDescription.entityForName(entityName, inManagedObjectContext: moc)!
        let request: NSFetchRequest = NSFetchRequest()
        request.entity = entityDescription
        
        if predicate != nil {
            request.predicate = predicate
        }
        if sortDes != nil{
            request.sortDescriptors = [sortDes!]
        }
        let array: [AnyObject] = try! moc.executeFetchRequest(request)
        return array
    }
    
    func getAllStoredProduct() -> [History]? {
        
        let businesses: [AnyObject] = fetchObjectsFromEntity("History", predicate: nil, sortDes: nil)
        
        if businesses.count <= 0 {
            print("Fatal: No business with the ID")
            return nil
        }
        
        return businesses as? [History]
    }
    
    // MARK: - Create and save data
    
    func saveData() {
        let moc: NSManagedObjectContext = managedObjectContext()
        
        do {
            try moc.save()
        } catch {
            print("Could not save")
        }
    }
    
    func createHistoryWithModel(historyObject: [String:AnyObject]) -> History {
        
        let moc: NSManagedObjectContext = managedObjectContext()
        let searchObject: History = (NSEntityDescription.insertNewObjectForEntityForName("History", inManagedObjectContext: moc) as! History)
        
        createHistoryWithObject(searchObject,historyObject: historyObject)
        saveData()
        
        return searchObject
    }
    
    
    func createHistoryWithObject(searchObject: History,historyObject: [String:AnyObject]){
        
        searchObject.movieTitle = historyObject["movieTitle"] as? String
        searchObject.moviePoster = historyObject["moviePoster"] as? String
        searchObject.movieImdbString = historyObject["movieImdbString"] as? String
        searchObject.movieType = historyObject["movieType"] as? String
        searchObject.movieYear = historyObject["movieYear"] as? String
    }
    
    
    func deleteAllEntities(nameEntity: String) {
            let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: nameEntity)
            fetchRequest.includesPropertyValues = false
        
            //only fetch the managedObjectID
            
            let moc: NSManagedObjectContext = managedObjectContext()
            
            let fetchedObjects: [AnyObject] = try! moc.executeFetchRequest(fetchRequest)
            
            for object in fetchedObjects {
                moc.deleteObject(object as! NSManagedObject)
            }
            
            saveData()
    }
    
    
    
}