//
//  MySymptoms+CoreDataProperties.swift
//  Lupus Health Tracker
//
//  Created by Hannah  Zacharia  on 7/21/21.
//
//

import Foundation
import CoreData


extension MySymptoms {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MySymptoms> {
        return NSFetchRequest<MySymptoms>(entityName: "MySymptoms")
    }

    @NSManaged public var symptomName: String?
    @NSManaged public var symptoms: NSSet?

}

// MARK: Generated accessors for symptoms
extension MySymptoms {

    @objc(addSymptomsObject:)
    @NSManaged public func addToSymptoms(_ value: MySymptoms)

    @objc(removeSymptomsObject:)
    @NSManaged public func removeFromSymptoms(_ value: MySymptoms)

    @objc(addSymptoms:)
    @NSManaged public func addToSymptoms(_ values: NSSet)

    @objc(removeSymptoms:)
    @NSManaged public func removeFromSymptoms(_ values: NSSet)

}

extension MySymptoms : Identifiable {

}
