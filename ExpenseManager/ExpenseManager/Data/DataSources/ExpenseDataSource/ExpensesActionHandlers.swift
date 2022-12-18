//
//  ExpensesActionHandlers.swift
//  ExpenseManager
//
//  Created by Dima on 9.11.22.
//

import Foundation
import CoreData

struct CreateExpenseHandler: CrudActionHandlerProtocol {
    func handle(_ data: CrudDataProtocol, _ collection: [CollectionEntityProtocol], _ context: NSManagedObjectContext?) -> [CollectionEntityProtocol]? {
        guard let context = context else { return nil }
        guard var collection = collection as? [Expense] else { return nil }
        guard let data = data as? ExpenseData else { return nil }
        let entity = Expense(context: context)
        entity.update(data)
        collection.append(entity)
        return collection
    }
}

struct UpdateExpenseHandler: CrudActionHandlerProtocol {
    func handle(_ data: CrudDataProtocol, _ collection: [CollectionEntityProtocol], _ context: NSManagedObjectContext?) -> [CollectionEntityProtocol]? {
        guard var collection = collection as? [Expense] else { return nil }
        guard let data = data as? ExpenseData else { return nil }
        return collection.map { element in
            if element.id?.uuidString == data.id {
                element.update(data)
            }
            return element
        }
    }
}

struct DeleteExpenseHandler: CrudActionHandlerProtocol {
    func handle(_ data: CrudDataProtocol, _ collection: [CollectionEntityProtocol], _ context: NSManagedObjectContext?) -> [CollectionEntityProtocol]? {
        guard var collection = collection as? [Expense] else { return nil }
        guard let data = data as? ExpenseData else { return nil }
        if let index = collection.firstIndex(where: { $0.id?.uuidString == data.id }){
            collection.remove(at: index)
        }
        return collection
    }
}
