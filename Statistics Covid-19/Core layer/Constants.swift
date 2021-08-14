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

struct InformationConstants {
    static let informationTitle = "Информация"
    static let symptomsTitle = "Симптомы"
    static let recommendations = "Рекомендации"
}

struct InformationFontConstants {
    static let largeBoldTitle = UIFont.boldSystemFont(ofSize: CGFloat(36))
    static let mediumBoldTitle = UIFont.boldSystemFont(ofSize: CGFloat(20))
    static let smallBoldTitle = UIFont.boldSystemFont(ofSize: CGFloat(16))
    static let smallText = UIFont.systemFont(ofSize: CGFloat(14))
}

struct ColorsConstants {
    static let recommendationBackground = UIColor(red: 0.992, green: 0.961, blue: 0.957, alpha: 1)
    static let descriptionRecommendation = UIColor(red: 0.557, green: 0.553, blue: 0.573, alpha: 1)
}

struct CellNames {
    static let informationCollectionCell = "CollectionCell"
}
