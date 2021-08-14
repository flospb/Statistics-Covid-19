//
//  Constants.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 08.08.2021.
//

import Foundation
import UIKit

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
}

struct InformationConstants {
    static let informationTitle = "Информация"
    static let symptomsTitle = "Симптомы"
    static let recommendations = "Рекомендации"
}

struct FontConstants {
    static let newCases = UIFont.boldSystemFont(ofSize: CGFloat(46))
    
    static let largeBoldTitle = UIFont.boldSystemFont(ofSize: CGFloat(36))
    static let mediumBoldTitle = UIFont.boldSystemFont(ofSize: CGFloat(20))
    static let smallBoldTitle = UIFont.boldSystemFont(ofSize: CGFloat(16))
    
    static let smallText = UIFont.systemFont(ofSize: CGFloat(14))
}

struct ColorsConstants {
    static let newCases = UIColor(red: 0.969, green: 0.580, blue: 0.006, alpha: 1)
    static let recommendationBackground = UIColor(red: 0.992, green: 0.961, blue: 0.957, alpha: 1)
    static let recommendationDescription = UIColor(red: 0.557, green: 0.553, blue: 0.573, alpha: 1)
}

struct CellNames {
    static let informationCollectionCell = "CollectionCell"
}
