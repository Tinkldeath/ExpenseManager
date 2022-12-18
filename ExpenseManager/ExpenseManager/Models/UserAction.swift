//
//  UserAction.swift
//  ExpenseManager
//
//  Created by Dima on 9.11.22.
//

import Foundation

enum Selection {
    case categories, expenses
    
    func toString() -> String {
        switch self {
        case .categories:
            return "Categories"
        case .expenses:
            return "Expenses"
        }
    }
    
    func reversed() -> Selection {
        switch self {
        case .categories:
            return .expenses
        case .expenses:
            return .categories
        }
    }
    
    func viewModel() -> SelectionViewModelProtocol {
        
    }
}

enum CrudAction {
    case create, edit, delete, change
}

struct UserAction {
    var action: CrudAction
    var data: CrudDataProtocol
}
