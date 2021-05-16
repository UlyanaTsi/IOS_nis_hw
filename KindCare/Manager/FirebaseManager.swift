//
//  FirebaseManager.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 13.05.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import Firebase
import CoreData

class FirebaseManager {
    static let shared = FirebaseManager()
    private var moc = NSManagedObjectContext.current
    private init() {}
    
    func loadFromFirebase(){
        let db = Firestore.firestore()
        let fetchRequest = NSFetchRequest<Brand>(entityName: "Brand")
        
        db.collection("brand").addSnapshotListener{ (snap, error) in
            if error != nil {
                print("ошибка")
                return
            } else {
                for i in snap!.documentChanges {
                    let name = i.document.get("name") as! String
                    let cf = i.document.get("isCrueltyFree") as! String
                    let vegan = i.document.get("isVegan") as! String
                    
                    if (self.checkBrand(name: name)){
                        let brand = Brand(context: self.moc)
                        brand.name = name
                        brand.isCrueltyFree = cf
                        brand.isVegan = vegan
                    } else {
                        fetchRequest.predicate = NSPredicate(format: "name=%@", (name))
                        
                        do{
                            let res = try self.moc.fetch(fetchRequest)
                            let brand = res.first!
                            
                            if (brand.isVegan != vegan){
                                brand.isVegan = vegan
                            }
                            
                            if (brand.isCrueltyFree != cf){
                                brand.isCrueltyFree = cf
                            }
                            
                        } catch {}
                    }
                    
                    do {
                        try self.moc.save()
                    } catch let nserror as NSError {
                        print("Что-то не сохраняется \(nserror)")
                    }
                }
            }
        }
        
        let request = NSFetchRequest<Brand>(entityName: "Brand")
        
        do{
            let res = try moc.fetch(request)
            
            for brand in res {
                if (db.collection("brand").whereField("name", isEqualTo: brand.name) == nil){
                    moc.delete(brand)
                }
            }
            
        } catch {}
    }
    
    private func checkBrand(name: String) -> Bool {
        let fetchRequest = NSFetchRequest<Brand>(entityName: "Brand")
        fetchRequest.predicate = NSPredicate(format: "name=%@", (name))
        
        do{
            let res = try moc.fetch(fetchRequest)
            
            return res.first == nil
        } catch {}
        
        return false
    }
    
    private func checkContainer() -> Bool{
        let fetchRequest = NSFetchRequest<Brand>(entityName: "Brand")
        
        var notEmpty : Bool = false
        
        do{
            let brands = try moc.fetch(fetchRequest)
            
            if (brands.count != 0){
                notEmpty = true
            }
        } catch {}
        
        return notEmpty
    }
}
