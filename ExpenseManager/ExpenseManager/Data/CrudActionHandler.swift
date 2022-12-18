//
//  CrudActionHandler.swift
//  ExpenseManager
//
//  Created by Dima on 9.11.22.
//

import Foundation
import CoreData

protocol CrudActionHandlerProtocol {
    func handle(_ data: CrudDataProtocol, _ collection: [CollectionEntityProtocol], _ context: NSManagedObjectContext?) -> [CollectionEntityProtocol]?
}
