//
//  StatisticsCovid19SnapshotTests.swift
//  Statistics Covid-19SnapshotTests
//
//  Created by Сергей Флоря on 15.09.2021.
//

import XCTest
import SnapshotTesting

@testable import Statistics_Covid_19

class StatisticsCovid19SnapshotTests: XCTestCase {
    var sut: UIViewController!
    var view: IInformationView!

    override func setUp() {
        super.setUp()
        view = InformationView(recommendations: RecommendationModel.recommendations)
        sut = InformationViewController(view: view)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        view = nil
    }

    func testScreenSnapshot() {
        // assert
        assertSnapshot(matching: sut, as: .image(on: .iPhoneSe))
    }
}
