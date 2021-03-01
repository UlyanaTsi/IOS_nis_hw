//
//  ItemsListViewModel.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import Foundation

class ItemsListViewModel: ObservableObject {
    
    @Published var items = [ItemViewModel]()
    
    func deleteItem(_ itemVM: ItemViewModel) -> Bool {
        
        var deleted = false
        
        do {
            try CoreDataManager.shared.deleteItem(item: itemVM.item)
            deleted = true
        } catch {
            print(error.localizedDescription)
        }
        
        return deleted
        
    }
    
    func fetchAllItems() {
        DispatchQueue.main.async {
            self.items = CoreDataManager.shared.getItems().map(ItemViewModel.init)
        }
    }
    
}




class ItemViewModel {
    
    var item: Item
    
    init(item: Item) {
        self.item = item
    }
    
    var itemId: String {
        
        guard let itemId = self.item.itemId else {
            return ""
        }
        
        return itemId.uuidString
        
    }
    
    var name: String {
        self.item.name ?? ""
    }
    
    var date: Date {
        self.item.openDate ?? Date()
    }
    
    var months: Int64 {
        self.item.months
    }
    
}
