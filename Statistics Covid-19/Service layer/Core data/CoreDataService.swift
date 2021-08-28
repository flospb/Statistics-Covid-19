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

                print(countryList)
                completion(countryList)
            }
        } catch {
            fatalError()
            // check
        }
    }

    func getCountryStatistics(countryCode: String, completion: @escaping (CountryStatisticsModel) -> Void) {
        let context = coreDataStack.container.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        // guard let country = self.getCountryStorageModel(code: countryCode, context: context) else { return }

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

    private func saveCountryList(countries: [CountryModel]) {
        coreDataStack.container.performBackgroundTask { context in
            // context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

            countries.forEach { item in
                _ = DBCountry(code: item.code, name: item.name, in: context)
            }

            self.coreDataStack.saveContext(in: context)
        }
    }

    func saveCountryStatistics(countryStatistics: CountryStatisticsModel) {
        coreDataStack.container.performBackgroundTask { context in
            // context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

            guard let country = self.getCountryStorageModel(code: countryStatistics.country.code, context: context) else { return }
            let db = self.dataMapper.getStatisticsStorageModel(statistics: countryStatistics, country: country, context: context)

            self.coreDataStack.saveContext(in: context)
        }
    }

    // MARK: - Helpers

    private func getCountryStorageModel(code: String, context: NSManagedObjectContext) -> DBCountry? {
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
            let countrySelected = code == countryCode
            let country = CountryModel(name: name, code: code, selected: countrySelected)
            countryList.append(country)
        }

        return countryList
    }
}
// protocol ICountryCoreDataService {
//    var coreDataStack: CoreDataStack { get }
//    func saveCountries(countries: [Country], completion: @escaping () -> Void)
//    func getCountryData(code: String, completion: @escaping (Country) -> Void)
// }
//
// class CompanyCoreDataService: ICountryCoreDataService {
//    var coreDataStack = CoreDataStack.shared
//
//    func saveCountries(countries: [Country], completion: @escaping () -> Void) {
//        self.coreDataStack.container.performBackgroundTask { context in
//            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//
//            for country in countries {
//                let countryObject = DBCountry(context: context)
//                countryObject.code = country.code
//                countryObject.name = country.name
//                countryObject.todayConfirmed = Int32(country.todayConfirmed ?? 0)
//                countryObject.yesterdayConfirmed = Int32(country.yesterdayConfirmed ?? 0)
//                countryObject.deaths = Int32(country.deaths ?? 0)
//                countryObject.confirmed = Int32(country.confirmed ?? 0)
//                countryObject.recovered = Int32(country.recovered ?? 0)
//                countryObject.critical = Int32(country.critical ?? 0)
//                countryObject.updateDate = country.updateDate
//                self.coreDataStack.saveContext(in: context)
//            }
//
//            DispatchQueue.main.async { completion() }
//        }
//    }
//
//    func getCountryData(code: String, completion: @escaping (Country) -> Void) {
//        let context = self.coreDataStack.container.viewContext
//        let request: NSFetchRequest<DBCountry> = DBCountry.fetchRequest()
//        let sortDescriptor = NSSortDescriptor(key: "\(#keyPath(DBCountry.updateDate))", ascending: false)
//        request.sortDescriptors = [sortDescriptor]
//
//        do {
//            let result = try context.fetch(request).compactMap { Country(country: $0) }
//            if result.count > 0 {
//                completion(result[0])
//            }
//        } catch {
//            fatalError()
//        }
//    }
// }
