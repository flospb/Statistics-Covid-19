//
//  DataMapper.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 22.08.2021.
//

import UIKit
import CoreData

protocol IStatisticsDataMapper {
    func getCountryListByStorageModel(countries: [DBCountry]) -> [CountryModel]
    func getStatisticsModelByCountry(statistics: CountryResponse, countryImage: CountryImageResponse?) -> CountryStatisticsModel
    func getStatisticsModelByStorageModel(statistics: DBStatistics) -> CountryStatisticsModel?
    func getStatisticsStorageModel(statistics: CountryStatisticsModel, country: DBCountry, context: NSManagedObjectContext) -> DBStatistics
}

class StatisticsDataMapper: IStatisticsDataMapper {
    private let dataFormatterService: IDataFormatterService

    init(dataFormatterService: IDataFormatterService) {
        self.dataFormatterService = dataFormatterService
    }

    func getCountryListByStorageModel(countries: [DBCountry]) -> [CountryModel] {
        var countryList = [CountryModel]()

        for item in countries {
            guard let name = item.name, let code = item.code else { continue }
            let country = CountryModel(code: code, name: name)
            countryList.append(country)
        }

        return countryList
    }

    func getStatisticsModelByCountry(statistics: CountryResponse, countryImage: CountryImageResponse?) -> CountryStatisticsModel {
        var image: UIImage?
        if let countryImageResponse = countryImage {
            image = UIImage(data: countryImageResponse.data)
        }

        let data = statistics.data

        var countryName = data.name
        if let name = NSLocale(localeIdentifier: "RU").localizedString(forCountryCode: data.code) {
            countryName = name
        }

        let country = CurrentCountryModel(code: data.code, name: countryName, image: image)
        var countryStatistics = CountryStatisticsModel(country: country)

//        countryStatistics.updateDate = dataFormatterService.getDateFromString(format: "yyyy-MM-dd", date: data.updateDate)

        if let totalData = data.totalData {
            countryStatistics.totalConfirmed = totalData.confirmed ?? 0
            countryStatistics.totalRecovered = totalData.recovered ?? 0
            countryStatistics.totalCritical = totalData.critical ?? 0
            countryStatistics.totalDeaths = totalData.deaths ?? 0
        }

        let timeLine = data.timeLine
        if !timeLine.isEmpty {
            countryStatistics.updateDate = dataFormatterService.getDateFromString(format: "yyyy-MM-dd", date: timeLine[0].date)
            countryStatistics.confirmedToday = timeLine[0].newConfirmed ?? 0
            countryStatistics.confirmedYesterday = timeLine[1].newConfirmed ?? 0
        }

        return countryStatistics
    }

    func getStatisticsModelByStorageModel(statistics: DBStatistics) -> CountryStatisticsModel? {
        guard let name = statistics.country?.name,
              let code = statistics.country?.code,
              let date = statistics.updateDate else { return nil }

        let countryModel = CurrentCountryModel(code: code, name: name, image: nil)
        var statisticsModel = CountryStatisticsModel(country: countryModel)

        statisticsModel.country = countryModel
        statisticsModel.updateDate = date
        statisticsModel.confirmedToday = Int(statistics.confirmedToday)
        statisticsModel.confirmedYesterday = Int(statistics.confirmedYesterday)
        statisticsModel.totalConfirmed = Int(statistics.totalConfirmed)
        statisticsModel.totalRecovered = Int(statistics.recovered)
        statisticsModel.totalCritical = Int(statistics.critical)
        statisticsModel.totalDeaths = Int(statistics.deaths)

        return statisticsModel
    }

    func getStatisticsStorageModel(statistics: CountryStatisticsModel,
                                   country: DBCountry,
                                   context: NSManagedObjectContext) -> DBStatistics {
        let storageModel = DBStatistics(context: context)

        storageModel.country = country
        storageModel.updateDate = statistics.updateDate
        storageModel.confirmedToday = Int32(statistics.confirmedToday)
        storageModel.confirmedYesterday = Int32(statistics.confirmedYesterday)
        storageModel.totalConfirmed = Int32(statistics.totalConfirmed)
        storageModel.recovered = Int32(statistics.totalRecovered)
        storageModel.critical = Int32(statistics.totalCritical)
        storageModel.deaths = Int32(statistics.totalDeaths)

        return storageModel
    }
}
