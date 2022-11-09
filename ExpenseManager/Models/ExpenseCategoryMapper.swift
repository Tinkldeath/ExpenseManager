//
//  TableModelMapper.swift
//  ExpenseManager
//
//  Created by Dima on 9.11.22.
//

import Foundation

struct ExpenseCategoryMapper {
    
    func map(category: Category) -> CategoryModel {
        return CategoryModel(title: category.title ?? "None", image: category.iconName)
    }
    
    func map(categories: [Category]) -> [CategoryModel] {
        return categories.map { category in
            return self.map(category: category)
        }
    }
    
    func map(expense: Expense) -> ExpenseModel {
        ExpenseModel(titleOrWatermark: expense.title ?? expense.watermark ?? "Unknown",
                            category: expense.category?.title ?? "None",
                            sum: "\(round((expense.sum*1000)/1000))$")
    }
    
    func map(expenses: [Expense]) -> TableModel {
        var model = TableModel()
        for expense in expenses {
            let mapped = self.map(expense: expense)
            if let _ = model[mapped.titleOrWatermark] {
                model[mapped.titleOrWatermark]!.append(mapped)
            }else {
                model.updateValue([mapped], forKey: mapped.titleOrWatermark)
            }
        }
        return model
    }
    
    func mapInputExpense(_ expense: Expense ,_ input: ExpenseInputModel){
        expense.title = input.title
        expense.watermark = input.watermark
        expense.sum = input.sum
        expense.date = input.date
    }
    
}
