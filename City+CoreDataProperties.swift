//
//  City+CoreDataProperties.swift
//  Project dwei14
//
//  Created by dwei14 on 10/31/19.
//  Copyright © 2019 dwei14. All rights reserved.
//
//   Core Data

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var name: String?
    @NSManaged public var des: String?
    @NSManaged public var image: Data?

}
