//
//  CrudData.swift
//  ExpenseManager
//
//  Created by Dima on 9.11.22.
//

import Foundation

protocol CrudDataProtocol {
    var title: String { get set }
}

struct ExpenseData: CrudDataProtocol {
    var id: String
    var title: String
    var watermark: String?
    var sum: Double
    var category: String
    var date: Date
    
    init?(id: String, title: String, watermark: String? = nil, sum: Double, category: String, date: Date) {
        guard sum > 0.0 else { return nil }
        guard !title.isEmpty else { return nil }
        self.id = id
        self.title = title
        self.watermark = watermark
        self.sum = sum
        self.category = category
        self.date = date
    }
}

struct CategoryData: CrudDataProtocol {
    var id: String
    var title: String
    var iconName: String?
    
    init?(id: String, title: String, iconName: String?){
        guard !title.isEmpty else { return nil }
        self.id = id
        self.title = title
        self.iconName = iconName
    }
}
