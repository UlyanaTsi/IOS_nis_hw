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
    // Дата открытия
    var itemOpenDate : Date = Date()
    // Срок годности
    var itemMonths : String = ""
    // Изображение, если его нет, то изображение по умолчанию.
    var itemImage: Data = UIImage(named: "default")!.pngData()!
    
    private var item : Item {
        let item = Item(context: CoreDataManager.shared.moc)
        item.itemId = UUID()
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
            return true
        } catch {}
        
        return false
    }
}
