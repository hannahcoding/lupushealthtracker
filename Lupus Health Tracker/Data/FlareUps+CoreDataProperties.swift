//
//  FlareUps+CoreDataProperties.swift
//  Lupus Health Tracker
//
//  Created by Hannah  Zacharia  on 7/21/21.
//
//

import Foundation
import CoreData


extension FlareUps {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlareUps> {
        return NSFetchRequest<FlareUps>(entityName: "FlareUps")
    }

    @NSManaged public var hadFlareUp: Bool
    @NSManaged public var date: Date

}

extension FlareUps : Identifiable {

}
