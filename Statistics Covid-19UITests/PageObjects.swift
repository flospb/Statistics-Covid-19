//
//  PageObjects.swift
//  Statistics Covid-19UITests
//
//  Created by Сергей Флоря on 15.09.2021.
//

import XCTest

protocol Page {
    var app: XCUIApplication { get }

    init(app: XCUIApplication)
}

class StatisticsPage: Page {
    var app: XCUIApplication
    var country: XCUIElement

    required init(app: XCUIApplication) {
        self.app = app
        self.country = app.staticTexts["Country"]
    }

    func countryTapped() -> CountryListPage {
        country.tap()
        return CountryListPage(app: app)
    }

    func getCurrentCountry() -> String {
        country.label
    }
}

class CountryListPage: Page {
    var app: XCUIApplication
    var selectedCountry: XCUIElement

    required init(app: XCUIApplication) {
        self.app = app
        self.selectedCountry = app.tables.staticTexts["Россия"]
    }

    func countrySelected() -> StatisticsPage {
        selectedCountry.tap()
        return StatisticsPage(app: app)
    }
}
