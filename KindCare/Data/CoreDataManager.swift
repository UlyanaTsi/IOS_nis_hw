//
//  CoreDataManager.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager{
    static let shared = CoreDataManager(moc: NSManagedObjectContext.current)
    
    var moc: NSManagedObjectContext
    
    private init(moc: NSManagedObjectContext){
        self.moc = moc
    }
    
    /*
     Fetch массива данных из CoreData
     */
    func getItems() -> [Item] {
        var items = [Item]()
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            items = try self.moc.fetch(request)
        } catch {}
        
        return items
    }
    
    /*
     Fetch данных из CoreData по id элемента
     */
    func getItemWithId(postId: UUID) throws -> Item? {
        // Предикат для посика по id
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "itemId=%@", (postId.uuidString))
        
        let res = try self.moc.fetch(request)
        return res.first
    }
    
    /*
     Сохранение данных в CoreData ч1
     */
    func saveItem(item : Item) throws {
        self.moc.insert(item)
        try save()
    }
    
    /*
     Fetch данных из CoreData
     */
    func updateItem(id: String, name: String, date: Date, months: Int64, image: Data) throws {
        // Находим по id элемент
        let item = try getItemWithId(postId: UUID(uuidString: id)!)
        
        // Меняем его данные.
        if let item = item {
            item.name = name
            item.openDate = date
            item.months = months
            item.image = image
            try save()
        }
    }
    
    /*
     Удаление данных из CoreData
     */
    func deleteItem(item: Item) throws {
        self.moc.delete(item)
        try save()
    }
    
    /*
     Сохранение данных в CoreData ч2 (само сохранение изменений контекста)
     */
    private func save() throws {
        try self.moc.save()
    }
}
