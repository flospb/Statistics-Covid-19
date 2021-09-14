//
//  DataMapperTests.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 14.09.2021.
//

import XCTest

class DataMapperTests: XCTestCase {
    var sut: IStatisticsDataMapper!
    var dataFormatter: DataFormatterMock!

    override func setUp() {
        super.setUp()
        dataFormatter = DataFormatterMock()
        sut = StatisticsDataMapper(dataFormatterService: dataFormatter)
    }

    override func tearDown() {
        super.tearDown()
        dataFormatter = nil
        sut = nil
    }

    func testThatCheckGettingStatisticsModelByCountry() {
        // arrange
        let countryData = CountryData(name: "Россия", code: "RU", updateDate: "", totalData: nil, timeLine: [])
        let countryResponse = CountryResponse(data: countryData)

        // act
        let result = sut.getStatisticsModelByCountry(statistics: countryResponse, countryImage: nil)

        // assert
        XCTAssertEqual(result.country.code, countryData.code)
        XCTAssertEqual(result.country.name, countryData.name)
        XCTAssertEqual(result.totalConfirmed, 0)
    }
}
