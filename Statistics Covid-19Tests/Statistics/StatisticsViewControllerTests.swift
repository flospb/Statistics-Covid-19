//
//  StatisticsViewControllerTests.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 13.09.2021.
//

import XCTest
@testable import Statistics_Covid_19

class StatisticsViewControllerTest: XCTestCase {
    var sut: StatisticsViewController!
    var view: IStatisticsView!
    var router: IMainRouter!
    var networkingService: INetworkingService!
    var coreDataService: ICoreDataService!
    var builder: IAssemblyBuilder!
    var userDefaultsService: IUserDefaultsService!

    override func setUp() {
        super.setUp()

        view = StatisticsViewMock()
        router = MainRouterMock()
        networkingService = NetworkingServiceMock()
        coreDataService = CoreDataServiceMock()
        builder = AssemblyBuilderMock()
        userDefaultsService = UserDefaultsServiceMock()

        sut = StatisticsViewController(view: view,
                                       router: router,
                                       networkingService: networkingService,
                                       coreDataService: coreDataService,
                                       builder: builder,
                                       userDefaultsService: userDefaultsService)

    }

    override func tearDown() {
        super.tearDown()
        view = nil
        router = nil
        networkingService = nil
        coreDataService = nil
        builder = nil
        userDefaultsService = nil
        sut = nil
    }

    func testThatCheckCountryTapped() {
        // arrange
//        let countryListViewController = CountryListViewControllerMock()
//
//        // act
//        router.openCountryListViewController(controller: countryListViewController)
//
//        // assert
//        XCAssertTrue(router.openCountryListViewControllerWasCalled)
    }
}
