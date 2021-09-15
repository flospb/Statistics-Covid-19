//
//  Statistics_Covid_19UITests.swift
//  Statistics Covid-19UITests
//
//  Created by Сергей Флоря on 08.08.2021.
//

import XCTest
@testable import Statistics_Covid_19

class StatisticsCovid19UITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
        app = nil
    }

    func testThatCheckOpeningListOfCountriesAndSelectionTheCountry() {
        // arrange
        let statisticsPage = StatisticsPage(app: app)
        let countryTestedLabel = "Россия"

        // act
        let selectedValue = statisticsPage.countryTapped().countrySelected().getCurrentCountry()

        // assert
        XCTAssertEqual(selectedValue, countryTestedLabel)
    }
}
