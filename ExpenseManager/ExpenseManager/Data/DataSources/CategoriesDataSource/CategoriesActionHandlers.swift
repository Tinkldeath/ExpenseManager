//
//  CategoriesActionHandlers.swift
//  ExpenseManager
//
//  Created by Dima on 9.11.22.
//

import Foundation
import CoreData

struct CreateCategoryHandler: CrudActionHandlerProtocol {
    func handle(_ data: CrudDataProtocol, _ collection: [CollectionEntityProtocol], _ context: NSManagedObjectContext?) -> [CollectionEntityProtocol]? {
        guard let context = context else { return nil }
        guard var collection = collection as? [Category] else { return nil }
        guard let data = data as? CategoryData else { return nil }
        let entity = Category(context: context)
        entity.update(data)
        collection.append(entity)
        return collection
    }
}

struct UpdateCategoryHandler: CrudActionHandlerProtocol {
    func handle(_ data: CrudDataProtocol, _ collection: [CollectionEntityProtocol], _ context: NSManagedObjectContext?) -> [CollectionEntityProtocol]? {
        guard var collection = collection as? [Category] else { return nil }
        guard let data = data as? CategoryData else { return nil }
        return collection.map { element in
            if element.id?.uuidString == data.id {
                element.update(data)
            }
            return element
        }
    }
}

struct DeleteCategoryHandler: CrudActionHandlerProtocol {
    func handle(_ data: CrudDataProtocol, _ collection: [CollectionEntityProtocol], _ context: NSManagedObjectContext?) -> [CollectionEntityProtocol]? {
        guard var collection = collection as? [Category] else { return nil }
        guard let data = data as? CategoryData else { return nil }
        if let index = collection.firstIndex(where: { $0.id?.uuidString == data.id }){
            collection.remove(at: index)
        }
        return collection
    }
}
