//
//  DBStatistics+CoreDataProperties.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 28.08.2021.
//
//

import Foundation
import CoreData

extension DBStatistics {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBStatistics> {
        return NSFetchRequest<DBStatistics>(entityName: "DBStatistics")
    }

    @NSManaged public var confirmedToday: Int32
    @NSManaged public var confirmedYesterday: Int32
    @NSManaged public var critical: Int32
    @NSManaged public var deaths: Int32
    @NSManaged public var recovered: Int32
    @NSManaged public var totalConfirmed: Int32
    @NSManaged public var updateDate: Date?
    @NSManaged public var country: DBCountry?
}

extension DBStatistics: Identifiable {}
