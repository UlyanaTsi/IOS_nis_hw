//
//  AppDelegate.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 01.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Если данные уже были загружены, то загружать снова не надо.
        let defaults = UserDefaults.standard
        let isPreloaded = defaults.bool(forKey: "isPreloaded")
        if !isPreloaded {
            preloadData()
            defaults.set(true, forKey: "isPreloaded")
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    //MARK: - CSV
    
    /*
     Парсинг файла в формате csv
     */
    func parseCSV (contentsOfURL: NSURL, encoding: String.Encoding, error: NSErrorPointer) -> [(name:String, isCrueltyFree:String, isVegan: String)]? {
        
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
     Загрука данных из csv в coredata
     */
    func preloadData () {
        if let contentsOfURL = Bundle.main.url(forResource: "CFBrands", withExtension: "csv") {
            
            removeData()
            
            var error:NSError?
            if let items = parseCSV(contentsOfURL: contentsOfURL as NSURL, encoding: String.Encoding.utf8, error: &error) {
                // Preload the menu items
                let managedObjectContext = persistentContainer.viewContext
                    for item in items {
                        let brand = Brand(context: managedObjectContext)
                        brand.name = item.name
                        brand.isCrueltyFree = item.isCrueltyFree
                        brand.isVegan = item.isVegan
                    }
                
                do {
                    try managedObjectContext.save()
                } catch let nserror as NSError {
                    fatalError("Что-то не сохраняется \(nserror)")
                }
            }
        }
    }
     
    /*
     Очистка данных, для избежания дублирования.
     */
    func removeData() {
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Brand>(entityName: "Brand")
        
        do{
            let brands = try managedObjectContext.fetch(fetchRequest)
            
            for brand in brands {
                managedObjectContext.delete(brand)
            }
        } catch {}
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "KindCare")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

