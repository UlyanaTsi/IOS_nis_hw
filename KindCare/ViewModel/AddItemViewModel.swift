//
//  AddItemViewModel.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import Foundation
import SwiftUI

/*
 ViewModel элемента, выступает посредником между CoreDataManager и View
 при сохранении элемента
 */
class AddItemViewModel : ObservableObject{
    // Название
    var itemName : String = ""
    // ID
    private var itemId : String = ""
    // Дата открытия
    var itemOpenDate : Date = Date()
    // Срок годности
    var itemMonths : String = ""
    // Изображение, если его нет, то изображение по умолчанию.
    var itemImage: Data = UIImage(named: "default")!.pngData()!
    
    private var item : Item {
        let item = Item(context: CoreDataManager.shared.moc)
        item.itemId = UUID()
        itemId = item.itemId!.uuidString
        item.name = itemName
        item.openDate = itemOpenDate
        item.image = itemImage
        
        let intMonths = Int64(itemMonths) ?? 0
        item.months = intMonths
        return item
    }
    
    /*
     Сохранение элемента.
     */
    func saveItem() -> Bool {
        do {
            try CoreDataManager.shared.saveItem(item: item)
            
            let date = itemOpenDate.adding(.month, value: Int(itemMonths) ?? 0)
            NotificationManager.shared.setNotification(date: date, name: itemName, id: itemId)
            
            return true
        } catch {}
        
        return false
    }
}
