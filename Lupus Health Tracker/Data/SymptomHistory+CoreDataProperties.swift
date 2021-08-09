//
//  SymptomHistory+CoreDataProperties.swift
//  Lupus Health Tracker
//
//  Created by Hannah  Zacharia  on 7/21/21.
//
//

import Foundation
import CoreData


extension SymptomHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SymptomHistory> {
        return NSFetchRequest<SymptomHistory>(entityName: "SymptomHistory")
    }

    //@NSManaged public var name: String?
    @NSManaged public var date: Date
    @NSManaged public var severity: NSAttributedString
    @NSManaged public var image: Data
    @NSManaged public var symptom: MySymptoms?

}

extension SymptomHistory : Identifiable {

}
