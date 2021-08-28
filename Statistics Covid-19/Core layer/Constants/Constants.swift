//
//  Constants.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 08.08.2021.
//

import Foundation
import UIKit

// MARK: - Text constants

struct TabBarConstants {
    static let statisticsTitle = "Статистика"
    static let statisticsImage = "chart.pie.fill"
    
    static let informationTitle = "Информация"
    static let informationImage = "info.circle.fill"
}

struct StatisticsConstants {
    static let statisticsTitle = "Статистика"
    static let casesTodayTitle = "Новых случаев за"
    static let casesYesterdayTitle = "в предыдущий день"
    static let casesTotalTitle = "Всего случаев"
    
    static let recoveredTitle = "Выздоровело"
    static let criticalTitle = "Болеет"
    static let deathsTitle = "Смертей"
    
    static let shareTitle = "Поделиться"
    static let refreshTitle = "Обновить"
    
    static let defaultCountryCode = "RU"
    static let listOpeningImage = "arrowtriangle.down.fill"
    
    static let defaultCasesValue = "0"
}

struct InformationConstants {
    static let informationTitle = "Информация"
    static let symptomsTitle = "Симптомы"
    static let recommendations = "Рекомендации"
}

struct CountryListConstants {
    static let selectedCountryImage = "checkmark"
}

struct CellNames {
    static let informationCollectionCell = "CollectionCell"
    static let countryListTableCell = "TableCell"
}

struct AdressesAPIConstants {   // TODO Check
    static let statisticsByCountry = "https://corona-api.com/countries/"
    static let countryList = "https://corona-api.com/countries"
    static let countryImage = "https://www.countryflags.io/"
    static let countryImageName = "/shiny/64.png"
}

struct AlertConstants {
    static let alertTitle = "Внимание!"
    static let alertActionOk = "Хорошо"
}

struct DefaultCountryConstants {
    static let countryCode = "RU"
    static let valueKey = "codeCountry"
}

struct CoreDataConstants {
    static let dataBaseName = "StatisticsCovid"
}

// MARK: - Fonts constants

struct FontConstants {
    static let casesToday = UIFont.boldSystemFont(ofSize: CGFloat(46))
    static let casesYesterday = UIFont.systemFont(ofSize: CGFloat(18))
    static let totalCases = UIFont.systemFont(ofSize: CGFloat(36))
    static let detailsCases = UIFont.systemFont(ofSize: CGFloat(16))
    
    static let largeBoldTitle = UIFont.boldSystemFont(ofSize: CGFloat(36))
    static let mediumBoldTitle = UIFont.boldSystemFont(ofSize: CGFloat(20))
    static let smallBoldTitle = UIFont.boldSystemFont(ofSize: CGFloat(16))
    
    static let mediumText = UIFont.systemFont(ofSize: CGFloat(18))
    static let smallText = UIFont.systemFont(ofSize: CGFloat(14))
}

// MARK: - Colors constants

struct ColorsConstants { 
    static let casesToday = UIColor(red: 0.969, green: 0.580, blue: 0.006, alpha: 1)
    static let casesYesterday = UIColor(red: 0.546, green: 0.546, blue: 0.546, alpha: 1)
    
    static let recovered = UIColor(red: 0.350, green: 0.743, blue: 0.449, alpha: 1)
    static let critical = UIColor(red: 0.835, green: 0.546, blue: 0.170, alpha: 1)
    static let deaths = UIColor(red: 0.778, green: 0.222, blue: 0.245, alpha: 1)
    
    static let shareBackground = UIColor(red: 0.952, green: 0.949, blue: 0.970, alpha: 1)
    static let refreshBackground = UIColor(red: 0.188, green: 0.481, blue: 1, alpha: 1)
    
    static let recommendationDescription = UIColor(red: 0.557, green: 0.553, blue: 0.573, alpha: 1)
}
