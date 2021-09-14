//
//  UserDefaultsServiceTests.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 12.09.2021.
//

import XCTest
@testable import Statistics_Covid_19

class UserDefaultsServiceTest: XCTestCase {
    var sut: IUserDefaultsService!
    var userDefaultsMock: UserDefaultsMock!
    var testKey: String!

    override func setUp() {
        super.setUp()
        userDefaultsMock = UserDefaultsMock()
        sut = UserDefaultsService(userDefaults: userDefaultsMock)
        testKey = "Test key"
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        userDefaultsMock = nil
        testKey = nil
    }

    func testThatCheckSavingData() {
        // arrange
        let testValue = "Test value"

        // act
        sut.saveObject(object: testValue, for: testKey)

        // assert
        XCTAssertTrue(userDefaultsMock.transmittedValueSet)
        XCTAssertTrue(userDefaultsMock.key == testKey)
    }

    func testThatCheckGettingData() {
        // act
        let _: String? = sut.getObject(for: testKey)

        // assert
        XCTAssertTrue(userDefaultsMock.transmittedValueReceived)
        XCTAssertTrue(userDefaultsMock.key == testKey)
    }
}
