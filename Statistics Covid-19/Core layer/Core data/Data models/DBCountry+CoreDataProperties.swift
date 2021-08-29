//
//  DBCountry+CoreDataProperties.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 28.08.2021.
//
//

import CoreData

extension DBCountry {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBCountry> {
        return NSFetchRequest<DBCountry>(entityName: "DBCountry")
    }

    @NSManaged public var code: String?
    @NSManaged public var name: String?
    @NSManaged public var statistics: NSSet?

    convenience init(code: String, name: String, in context: NSManagedObjectContext) {
        self.init(context: context)
        self.code = code
        self.name = name
    }
}

// MARK: - Generated accessors for statistics

extension DBCountry {
    @objc(addStatisticsObject:)
    @NSManaged public func addToStatistics(_ value: DBStatistics)

    @objc(removeStatisticsObject:)
    @NSManaged public func removeFromStatistics(_ value: DBStatistics)

    @objc(addStatistics:)
    @NSManaged public func addToStatistics(_ values: NSSet)

    @objc(removeStatistics:)
    @NSManaged public func removeFromStatistics(_ values: NSSet)
}

extension DBCountry: Identifiable {}
