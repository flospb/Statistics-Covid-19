//
//  StatisticsModel.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 14.08.2021.
//

import UIKit

struct CountryModel {
    let code: String
    let name: String
}

struct CurrentCountryModel {
    let code: String
    let name: String
    let image: UIImage?
}

struct CountryStatisticsModel {
    let country: CurrentCountryModel
    var updateDate: Date?
    var confirmedToday: Int
    var confirmedYesterday: Int

    var totalConfirmed: Int
    var totalRecovered: Int
    var totalCritical: Int
    var totalDeaths: Int

    init(country: CurrentCountryModel) {
        self.country = country

        let defaultValue = 0

        self.confirmedToday = defaultValue
        self.confirmedYesterday = defaultValue

        self.totalConfirmed = defaultValue
        self.totalRecovered = defaultValue
        self.totalCritical = defaultValue
        self.totalDeaths = defaultValue
    }
}

struct TotalCasesModel {
    let recovered: CGFloat
    let critical: CGFloat
    let deaths: CGFloat
}
