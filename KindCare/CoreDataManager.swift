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
    
    func getItems() -> [Item] {
        var items = [Item]()
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            items = try self.moc.fetch(request)
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        
        return items
    }
    
    func saveItem(item : Item) throws{
        self.moc.insert(item)
        try save()
    }
    
    private func save() throws {
        try self.moc.save()
    }
    
    func deleteItem(item: Item) throws {
        self.moc.delete(item)
        try save()
    }
}
