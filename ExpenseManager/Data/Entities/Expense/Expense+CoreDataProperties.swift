//
//  Expense+CoreDataProperties.swift
//  
//
//  Created by Dima on 9.11.22.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var date: Date?
    @NSManaged public var sum: Double
    @NSManaged public var title: String?
    @NSManaged public var watermark: String?
    @NSManaged public var category: Category?

}
