//
//  Brand+CoreDataProperties.swift
//  KindCare
//
//  Created by Ульяна Цимбалистая on 28.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//
//

import Foundation
import CoreData


extension Brand {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Brand> {
        return NSFetchRequest<Brand>(entityName: "Brand")
    }

    @NSManaged public var isCrueltyFree: String?
    @NSManaged public var isVegan: String?
    @NSManaged public var name: String?
    @NSManaged public var isFavorite: Bool

}
