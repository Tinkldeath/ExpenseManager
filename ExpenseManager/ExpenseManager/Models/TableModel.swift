//
//  PresentationStruct.swift
//  ExpenseManager
//
//  Created by Dima on 9.11.22.
//

import Foundation

typealias TableModel = [String:[ExpenseModel]]

extension TableModel {
    func indexForSection(_ section: Int) -> TableModel.Keys.Index {
        return self.keys.index(self.startIndex, offsetBy: section)
    }
    
    func valueFor(_ section: Int, _ row: Int) -> ExpenseModel {
        return self[self.keyForSection(section)]![row]
    }
    
    func keyForSection(_ section: Int) -> String {
        let index = self.indexForSection(section)
        return self.keys[index]
    }
}
