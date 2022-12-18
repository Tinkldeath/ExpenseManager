//
//  Category+CoreDataProperties.swift
//  
//
//  Created by Dima on 9.11.22.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var iconName: String?
    @NSManaged public var title: String?
    @NSManaged public var id: UUID?
    @NSManaged public var expense: NSSet?

}

// MARK: Generated accessors for expense
extension Category {

    @objc(addExpenseObject:)
    @NSManaged public func addToExpense(_ value: Expense)

    @objc(removeExpenseObject:)
    @NSManaged public func removeFromExpense(_ value: Expense)

    @objc(addExpense:)
    @NSManaged public func addToExpense(_ values: NSSet)

    @objc(removeExpense:)
    @NSManaged public func removeFromExpense(_ values: NSSet)

}
