//
//  DataFormatterServiceTests.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 13.09.2021.
//

import XCTest
@testable import Statistics_Covid_19

class DataFormatterServiceTest: XCTestCase {
    var sut: IDataFormatterService!

    override func setUp() {
        super.setUp()
        sut = DataFormatterService()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testThatCheckСhangingDateFormat() {
        // arrange
        let changedDate = "2021-10-01"
        let oldFormat = "yyyy-MM-dd"
        let newFormat = "dd.MM.YYYY"
        let correctResult = "01.10.2021"

        // act
        let result = sut.changeDateFormat(changedDate: changedDate, oldFormat: oldFormat, newFormat: newFormat)

        // assert
        XCTAssertEqual(result, correctResult)
    }

    func testThatCheckDecimalFormatting() {
        // arrange
        let number = 12345
        let correctResult = "12 345"

        // act
        let result = sut.decimalFormatting(number: number)

        // assert
        XCTAssertEqual(result, correctResult)
    }
}
