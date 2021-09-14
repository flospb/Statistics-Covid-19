//
//  NetworkingServiceTests.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 14.09.2021.
//

import XCTest

class NetworkingServiceTests: XCTestCase {
    var sut: INetworkingService!
    var requestSender: IRequestSender!
    var dataMapper: IStatisticsDataMapper!

    override func setUp() {
        super.setUp()
        requestSender = RequestSenderMock()
        dataMapper = DataMapperMock()
        sut = NetworkingService(requestSender: requestSender, dataMapper: dataMapper)
    }

    override func tearDown() {
        super.tearDown()
        requestSender = nil
        dataMapper = nil
        sut = nil
    }

    func testThatCheckSuccessFetchingDataByCountry() {
        // arrange
        let codeCountry = "RU"
        let countryName = "Россия"
        let countryModel = CurrentCountryModel(code: codeCountry, name: countryName, image: nil)
        let correctResult = CountryStatisticsModel(country: countryModel)
        let didReceiveResponse = expectation(description: #function)
        var result: CountryStatisticsModel?

        // act
        sut.fetchDataByCountry(codeCurrentCountry: codeCountry) { dataResult in
            switch dataResult {
            case .success(let countryData):
                result = countryData
            case .failure:
                result = nil
            }
            didReceiveResponse.fulfill()
        }

        wait(for: [didReceiveResponse], timeout: 5)

        // assert
        XCTAssertEqual(result?.country.code, correctResult.country.code)
    }
}
