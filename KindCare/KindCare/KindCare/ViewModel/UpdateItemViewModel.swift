//
//  UpdateItemViewModel.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import Foundation
import SwiftUI

/*
ViewModel элемента, выступает посредником между CoreDataManager и View
при изменении элемента.
*/
class UpdateItemViewModel : ObservableObject{
    /*
     Вызывает функцию обновление элемента в moc переданными параметрами.
     */
    func update(viewState: ItemViewState) -> Bool {
        do{
            let intMonths = Int64(viewState.itemMonths) ?? 0
            try CoreDataManager.shared.updateItem(id: viewState.itemId, name: viewState.itemName, date: viewState.itemOpenDate, months: intMonths, image: viewState.itemImage)
            return true
        } catch {}
        
        return false
    }
}

/*
 Представляет собой элемент с изменениями.
 */
struct ItemViewState{
    var itemId: String = ""
    var itemName: String = ""
    var itemOpenDate: Date = Date()
    var itemMonths: String = ""
    var itemImage: Data = UIImage(named: "default")!.pngData()!
}
