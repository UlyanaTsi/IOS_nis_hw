//
//  Commit+CoreDataProperties.swift
//  CommitsApp
//
//  Created by Ульяна Цимбалистая on 29.11.2020.
//  Copyright © 2020 Ульяна Цимбалистая. All rights reserved.
//
//

import Foundation
import CoreData


extension Commit {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Commit> {
        return NSFetchRequest<Commit>(entityName: "Commit")
    }

    @NSManaged public var data: Date
    @NSManaged public var message: String
    @NSManaged public var sha: String
    @NSManaged public var url: String
    @NSManaged public var author: Author

}
