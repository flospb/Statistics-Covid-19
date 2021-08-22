//
//  DataMapper.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 22.08.2021.
//

import Foundation
import UIKit

protocol IStatisticsDataMapper {
    func countryListConversion(countries: CountriesResponse) -> [CountryModel]
    func statisticsByCountry(statistics: CountryResponse, countryImage: CountryImageResponse?) -> CountryStatisticsModel
}

class StatisticsDataMapper: IStatisticsDataMapper {
    
    func countryListConversion(countries: CountriesResponse) -> [CountryModel] {
        var countryList = [CountryModel]()
        
        for item in countries.data {
            let selectedCountry = item.code == StatisticsConstants.defaultCountryCode
            let country = CountryModel(name: item.name, code: item.code, selected: selectedCountry)
            countryList.append(country)
        }
        
        return countryList
    }
    
    func statisticsByCountry(statistics: CountryResponse, countryImage: CountryImageResponse?) -> CountryStatisticsModel {
        var image: UIImage?
        if let countryImageResponse = countryImage {
            image = UIImage(data: countryImageResponse.data)
        }
        
        let data = statistics.data
        
        let country = CurrentCountryModel(name: data.name, code: data.code, image: image)
        var countryStatistics = CountryStatisticsModel(country: country)
        
        countryStatistics.updateDate = data.updateDate

        if let totalData = data.totalData {
            countryStatistics.totalConfirmed = totalData.confirmed ?? 0
            countryStatistics.totalRecovered = totalData.recovered ?? 0
            countryStatistics.totalCritical = totalData.critical ?? 0
            countryStatistics.totalDeaths = totalData.deaths ?? 0
        }
        
        let timeLine = data.timeLine
        if timeLine.count != 0 {
            countryStatistics.updateDate = timeLine[0].date
            countryStatistics.confirmedToday = timeLine[0].newConfirmed ?? 0
            countryStatistics.confirmedYesterday = timeLine[1].newConfirmed ?? 0
        }
        
        return countryStatistics
    }
}
