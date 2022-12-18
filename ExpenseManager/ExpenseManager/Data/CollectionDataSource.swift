//
//  CollectionViewDataSource.swift
//  ExpenseManager
//
//  Created by Dima on 9.11.22.
//

import Foundation

protocol CollectionDataSourceProtocol {
    func fetchCollection(_ completionHandler: @escaping (_ data: [CollectionItem], _ error: Error?) -> Void)
    func handleUserAction(_ action: UserAction)
    func saveCollection()
}
