//
//  ExpenseJournal.swift
//  ExpenseManager
//
//  Created by Dima on 9.11.22.
//

import Foundation
import UIKit

final class ExpenseJournal {
    
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var mapper = ExpenseCategoryMapper()
    private var expenses: [Expense] = []
    private var categories: [Category] = []
    
    init() {
        let expenses = try? self.context.fetch(Expense.fetchRequest())
        let categories = try? self.context.fetch(Category.fetchRequest())
        self.expenses = expenses ?? []
        self.categories = categories ?? []
    }
    
    func tableModel() -> TableModel {
        return mapper.map(expenses: self.expenses)
    }
    
    func categoriesModel() -> [CategoryModel] {
        return mapper.map(categories: self.categories)
    }
    
    func addExpense(_ input: ExpenseInputModel) {
        let expense = Expense(context: self.context)
        if let category = self.categories.first(where: { $0.title == input.title }) {
            expense.category = category
        }
        self.mapper.mapInputExpense(expense, input)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
}
