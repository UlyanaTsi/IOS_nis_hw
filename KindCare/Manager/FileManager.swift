//
//  FileManager.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 13.05.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import Foundation
import CoreData

class FileManager {
    static let shared = FileManager()
    
    private init() {}
    
    /*
     Парсинг данных из файла формата csv в
     */
    private func parseCsv (contentsOfURL: NSURL, encoding: String.Encoding, error: NSErrorPointer) -> [(name:String, isCrueltyFree:String, isVegan: String)]? {
        
        let delimiter = ";"
        var items:[(name:String, isCrueltyFree:String, isVegan: String)]?
        if let content = try? String(contentsOf: contentsOfURL as URL, encoding: encoding) {
            items = []
            let lines:[String] = content.components(separatedBy: NSCharacterSet.newlines) as [String]
            for line in lines {
                var values:[String] = []
                if line != "" {
                    values = line.components(separatedBy: delimiter)
                    let item = (name: values[0], isCrueltyFree: values[1], isVegan: values[2])
                    items?.append(item)
                }
            }
        }
        return items
    }
    
    /*
     Загрука данных из csv в БД
     */
    func loadFromCsv() {
        if let contentsOfURL = Bundle.main.url(forResource: "CFBrands", withExtension: "csv") {
            
            removeData()
            
            var error:NSError?
            if let items = parseCsv(contentsOfURL: contentsOfURL as NSURL, encoding: String.Encoding.utf8, error: &error) {
                // Preload the menu items
                let managedObjectContext = NSManagedObjectContext.current
                for item in items {
                    let brand = Brand(context: managedObjectContext)
                    brand.name = item.name
                    brand.isCrueltyFree = item.isCrueltyFree
                    brand.isVegan = item.isVegan
                }
                
                do {
                    try managedObjectContext.save()
                } catch let nserror as NSError {
                    print("Что-то не сохраняется \(nserror)")
                }
            }
        }
    }
    
    /*
     Очистка данных, для избежания дублирования.
     */
    private func removeData() {
        let managedObjectContext = NSManagedObjectContext.current
        let fetchRequest = NSFetchRequest<Brand>(entityName: "Brand")
        
        do{
            let brands = try managedObjectContext.fetch(fetchRequest)
            
            for brand in brands {
                managedObjectContext.delete(brand)
            }
        } catch {}
    }
}
