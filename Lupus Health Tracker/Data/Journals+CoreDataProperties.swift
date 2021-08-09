//
//  Journals+CoreDataProperties.swift
//  Lupus Health Tracker
//
//  Created by Hannah  Zacharia  on 7/21/21.
//
//

//import Foundation
//import CoreData
//
//
//extension Journals {
//
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<Journals> {
//        return NSFetchRequest<Journals>(entityName: "Journals")
//    }
//
//    @NSManaged public var createdAt: Date?
//    @NSManaged public var stressLevel: Int
//    @NSManaged public var bodyText: String?
//
//}
//
//extension Journals : Identifiable {
//
//}

import CoreData

@objc(Note)
class Note: NSManagedObject
{
    @NSManaged var id: NSNumber
    @NSManaged var title: String
    @NSManaged override var description: String
    @NSManaged override var isDeleted: Bool
    
}
