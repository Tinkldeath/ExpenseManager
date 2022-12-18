//
//  CollectionPresenter.swift
//  ExpenseManager
//
//  Created by Dima on 9.11.22.
//

import Foundation

protocol CollectionViewModelProtocol {
    var items: [CollectionItem] { get }
    var selection: Selection { get }
    
    func fetchItems()
    func changeSelectionAction(_ selection: Selection)
    func userAction(_ action: UserAction)
}

final class CollectionViewModel: CollectionViewModelProtocol {
    
    private var dataSources: [Selection:CollectionDataSourceProtocol] = [
        .expenses: ExpensesDataSource(),
        .categories: CategoriesDataSource()
    ]
    
    private(set) var items: [CollectionItem] = []
    private(set) var selection: Selection = .expenses
    private weak var delegate: CollectionViewDelegateProtocol? = nil
    
    init(delegate: CollectionViewDelegateProtocol? = nil) {
        self.delegate = delegate
    }
    
    func fetchItems() {
        if let source = self.dataSources[self.selection] {
            source.fetchCollection { [weak self] data, error in
                self?.items = data
                self?.delegate?.updateView()
            }
        }
    }
    
    func userAction(_ action: UserAction) {
        if let source = self.dataSources[self.selection] {
            source.handleUserAction(action)
            self.delegate?.updateView()
        }
    }
    
    func changeSelectionAction(_ selection: Selection) {
        self.selection = selection
        self.fetchItems()
    }
    
}
