//
//  MyMedications+CoreDataProperties.swift
//  Lupus Health Tracker
//
//  Created by Hannah  Zacharia  on 7/21/21.
//
//

import Foundation
import CoreData


extension MyMedications {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyMedications> {
        return NSFetchRequest<MyMedications>(entityName: "MyMedications")
    }

    @NSManaged public var medName: String?
    @NSManaged public var takeTime: Date?
//    @NSManaged public var unit: String?
//    @NSManaged public var frequency: String?

}

extension MyMedications : Identifiable {

}
