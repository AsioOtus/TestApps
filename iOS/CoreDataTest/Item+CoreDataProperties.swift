//
//  Item+CoreDataProperties.swift
//  TestApps
//
//  Created by Anton on 20/10/2021.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var value: String?

}
