//
//  Expense+CoreDataClass.swift
//  
//
//  Created by Dima on 9.11.22.
//
//

import Foundation
import CoreData
import UIKit

@objc(Expense)
public class Expense: NSManagedObject {
    
}

extension Expense: CollectionEntityProtocol {
    
    func toCollectionItem() -> CollectionItem {
        return CollectionItem(
            id: self.id?.uuidString,
            title: self.watermark ?? self.title ?? "Unknown",
            details: "\(round(self.sum*1000/1000))",
            imageName: nil,
            categoryName: self.category?.title ?? "None")
    }
    
    private func findCategory(_ name: String) -> Category? {
        do {
            let category = try (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext.fetch(Category.fetchRequest()).first(where: { $0.title == name })
            return category
        }catch {
            return nil
        }
    }
    
    func update(_ data: CrudDataProtocol) {
        guard let data = data as? ExpenseData else { return }
        self.id = UUID(uuidString: data.id)
        self.title = data.title
        self.watermark = data.watermark
        self.category = self.findCategory(data.category)
        self.sum = data.sum
        self.date = data.date
    }
}
