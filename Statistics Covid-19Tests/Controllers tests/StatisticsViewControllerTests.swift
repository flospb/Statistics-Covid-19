//
//  StatisticsViewControllerTests.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 13.09.2021.
//

import XCTest
import UIKit
@testable import Statistics_Covid_19

class StatisticsViewControllerTest: XCTestCase {
    var sut: IStatisticsViewController!
    var view: StatisticsViewMock!
    var router: MainRouterMock!
    var networkingService: NetworkingServiceMock!
    var coreDataService: CoreDataServiceMock!
    var builder: AssemblyBuilderMock!
    var userDefaultsService: UserDefaultsServiceMock!

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

    func testThatCheckShareButtonTapped() {
        // arrange
        let activityViewControllerMock = UIActivityViewController(activityItems: [], applicationActivities: nil)

        // act
        router.openActivityViewController(activityViewController: activityViewControllerMock)

        // assert
        XCTAssertTrue(router.openActivityViewControllerWasCalled)
    }
}
