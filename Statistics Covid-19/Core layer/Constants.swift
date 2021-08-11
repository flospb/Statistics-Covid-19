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

struct TextFontConstants {
    static let bigBoldTitle = UIFont.boldSystemFont(ofSize: CGFloat(36))
    static let boldTitle = UIFont.boldSystemFont(ofSize: CGFloat(20))
    static let boldText = UIFont.boldSystemFont(ofSize: CGFloat(18))
    static let text = UIFont.systemFont(ofSize: CGFloat(18))
}

struct CellNames {
    static let informationCollectionCell = "CollectionCell"
}
