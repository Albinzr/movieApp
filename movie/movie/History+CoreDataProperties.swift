//
//  History+CoreDataProperties.swift
//  movie
//
//  Created by Albin on 02/08/16.
//  Copyright © 2016 Albin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension History {

    @NSManaged var movieTitle: String?
    @NSManaged var movieImdbString: String?
    @NSManaged var moviePoster: String?
    @NSManaged var movieYear: String?
    @NSManaged var movieType: String?

}
