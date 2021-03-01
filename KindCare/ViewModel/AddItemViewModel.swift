//
//  AddItemViewModel.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import Foundation

class AddItemViewModel : ObservableObject{
    
    var itemName : String = ""
    var itemOpenDate : Date = Date()
    var itemMonths : Int64 = 12
    
    private var item : Item {
        let item = Item(context: CoreDataManager.shared.moc)
        item.itemId = UUID()
        item.name = itemName
        item.openDate = itemOpenDate
        item.months = itemMonths
        return item
    }
    
    func saveItem() -> Bool {
        do {
            try CoreDataManager.shared.saveItem(item: item)
            return true
        } catch {
            print(error.localizedDescription)
        }
        
        return false
    }
}
