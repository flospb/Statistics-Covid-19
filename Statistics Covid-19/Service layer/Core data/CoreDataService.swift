//
//  CoreDataService.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 28.08.2021.
//

import CoreData

protocol ICoreDataService {
    func getCountryList(completion: @escaping ([CountryModel]) -> Void)
    func getCountryStatistics(countryCode: String, completion: @escaping (CountryStatisticsModel) -> Void)
    func saveCountryStatistics(countryStatistics: CountryStatisticsModel)
//    func saveCountryStatistics(statistics: CountryStatisticsModel)
//    func getCountryStatistics(code: String, completion: @escaping ([CountryStatisticsModel]) -> Void)
}

class CoreDataService: ICoreDataService {
    private let coreDataStack: ICoreDataStack
    private let dataMapper: IStatisticsDataMapper

    // MARK: - Initialization

    init(coreDataStack: ICoreDataStack, dataMapper: IStatisticsDataMapper) {
        self.coreDataStack = coreDataStack
        self.dataMapper = dataMapper
    }

    // MARK: - Fetching data

    func getCountryList(completion: @escaping ([CountryModel]) -> Void) {
        let context = coreDataStack.container.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy // check

        let request: NSFetchRequest<DBCountry> = DBCountry.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "\(#keyPath(DBCountry.name))", ascending: true)
        request.sortDescriptors = [sortDescriptor]

        do {
            let result = try context.fetch(request)
            if result.count == 0 {
                let countryList = fillCountryList()
                saveCountryList(countries: countryList)
                completion(countryList)
            } else {
                let countryList = dataMapper.getCountryListByStorageModel(countries: result)
                completion(countryList)
            }
        } catch {
            fatalError()
            // check
        }
    }

    func getCountryStatistics(countryCode: String, completion: @escaping (CountryStatisticsModel) -> Void) {
        let context = coreDataStack.container.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy // check

        let request: NSFetchRequest<DBStatistics> = DBStatistics.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "\(#keyPath(DBStatistics.updateDate))", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        request.predicate = NSPredicate(format: "\(#keyPath(DBStatistics.country.code)) = '\(countryCode)'")

        do {
            guard let result = try context.fetch(request).first else { return }
            guard let statistics = dataMapper.getStatisticsModelByStorageModel(statistics: result) else { return }
            completion(statistics)
        } catch {
            print("")
            // check
        }
    }

    // MARK: - Saving data

    func saveCountryStatistics(countryStatistics: CountryStatisticsModel) {
        coreDataStack.container.performBackgroundTask { context in
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy // check
            guard let country = self.getCountryStorageModel(code: countryStatistics.country.code, context: context) else { return }
            _ = self.dataMapper.getStatisticsStorageModel(statistics: countryStatistics, country: country, context: context) // check

            self.coreDataStack.saveContext(in: context)
        }
    }

    // MARK: - Helpers

    private func saveCountryList(countries: [CountryModel]) {
        coreDataStack.container.performBackgroundTask { context in
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy // check
            countries.forEach { item in
                _ = DBCountry(code: item.code, name: item.name, in: context) // check
            }
            self.coreDataStack.saveContext(in: context)
        }
    }

    private func getCountryStorageModel(code: String, context: NSManagedObjectContext) -> DBCountry? {
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy // check
        
        let request: NSFetchRequest<DBCountry> = DBCountry.fetchRequest()
        request.predicate = NSPredicate(format: "\(#keyPath(DBCountry.code)) = '\(code)'")

        do {
            guard let country = try context.fetch(request).first else { return nil }
            return country
        } catch {
            fatalError()
        }
    }

    private func fillCountryList() -> [CountryModel] {
        let countryCode = StatisticsConstants.defaultCountryCode
        let countryCodes = NSLocale.isoCountryCodes
        var countryList = [CountryModel]()

        for code in countryCodes {
            guard let name = NSLocale(localeIdentifier: countryCode).localizedString(forCountryCode: code) else { continue }
            let country = CountryModel(code: code, name: name)
            countryList.append(country)
        }
        countryList.sort { $0.name < $1.name }
        
        return countryList
    }
}
