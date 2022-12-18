//
//  CollectionEntity.swift
//  ExpenseManager
//
//  Created by Dima on 9.11.22.
//

import Foundation

protocol CollectionEntityProtocol {
    func toCollectionItem() -> CollectionItem
    func update(_ data: CrudDataProtocol)
}
