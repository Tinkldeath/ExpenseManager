//
//  Category+CoreDataClass.swift
//  
//
//  Created by Dima on 9.11.22.
//
//

import Foundation
import CoreData

@objc(Category)
public class Category: NSManagedObject {

}

extension Category: CollectionEntityProtocol {
    
    func toCollectionItem() -> CollectionItem {
        return CollectionItem(
            id: self.id?.uuidString,
            title: self.title ?? "None",
            details: nil,
            imageName: self.iconName,
            categoryName: nil)
    }
    
    func update(_ data: CrudDataProtocol) {
        guard let data = data as? CategoryData else { return }
        self.id = UUID(uuidString: data.id)
        self.title = data.title
        self.iconName = data.iconName
    }
    
}
