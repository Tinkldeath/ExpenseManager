//
//  ExpenseModel.swift
//  ExpenseManager
//
//  Created by Dima on 9.11.22.
//

import Foundation

enum InputError: Error {
    case emptyString, invalidNumber
}

struct ExpenseModel: Hashable{
    var titleOrWatermark: String
    var category: String
    var sum: String
}

struct CategoryModel {
    var title: String
    var image: String?
}

struct ExpenseInputModel {
    var title: String
    var watermark: String?
    var sum: Double
    var date: Date
    var category: String?
    
    init(title: String, watermark: String?, sum: String, date: Date, category: String?) throws {
        guard !title.isEmpty else { throw InputError.emptyString }
        guard let castedSum = Double(sum) else { throw InputError.invalidNumber }
        guard castedSum > 0 else { throw InputError.invalidNumber }
        self.title = title
        self.watermark = watermark
        self.sum = castedSum
        self.date = date
        self.category = category
    }
    
}
