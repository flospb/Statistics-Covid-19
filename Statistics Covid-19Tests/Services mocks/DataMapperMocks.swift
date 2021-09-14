//
//  DataMapperMocks.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 14.09.2021.
//

import Foundation
import CoreData

class DataMapperMock: IStatisticsDataMapper {
    func getCountryListByStorageModel(countries: [DBCountry]) -> [CountryModel] {
        return [CountryModel(code: "", name: "")]
    }

    func getStatisticsModelByCountry(statistics: CountryResponse, countryImage: CountryImageResponse?) -> CountryStatisticsModel {
        return CountryStatisticsModel(country: CurrentCountryModel(code: "RU", name: "Россия", image: nil))
    }

    func getStatisticsModelByStorageModel(statistics: DBStatistics) -> CountryStatisticsModel? {
        return nil
    }

    func getStatisticsStorageModel(statistics: CountryStatisticsModel, country: DBCountry, context: NSManagedObjectContext) -> DBStatistics {
        return DBStatistics()
    }
}
