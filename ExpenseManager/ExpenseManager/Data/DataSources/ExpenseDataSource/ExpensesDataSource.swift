//
//  ExpensesDataSource.swift
//  ExpenseManager
//
//  Created by Dima on 9.11.22.
//

import Foundation
import UIKit
import CoreData

final class ExpensesDataSource: CollectionDataSourceProtocol {
    
    private weak var appDelegate: AppDelegate?
    private var context: NSManagedObjectContext?
    private var entities: [Expense]
    private var actionHandlers: [CrudAction: CrudActionHandlerProtocol] = [
        .create: CreateExpenseHandler(),
        .edit: UpdateExpenseHandler(),
        .delete: DeleteExpenseHandler()
    ]
    
    init() {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.context = self.appDelegate?.persistentContainer.viewContext
        self.entities = []
    }
    
    func fetchCollection(_ completionHandler: @escaping ([CollectionItem], Error?) -> Void) {
        do {
            let entities = try self.context?.fetch(Expense.fetchRequest()) ?? []
            self.entities = entities
            completionHandler(entities.map({ $0.toCollectionItem() }), nil)
        }catch {
            completionHandler([], error)
        }
    }
    
    func handleUserAction(_ action: UserAction) {
        if let handler = self.actionHandlers[action.action]{
            guard let entities = handler.handle(action.data, self.entities, self.context) as? [Expense] else { return }
            self.entities = entities
            self.saveCollection()
        }
    }
    
    func saveCollection() {
        self.appDelegate?.saveContext()
    }
    
}
