//
//  InformationControllerTests.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 13.09.2021.
//

import XCTest
@testable import Statistics_Covid_19

class InformationControllerTest: XCTestCase {
    var sut: InformationViewController!
    var view: InformationViewMock!

    override func setUp() {
        super.setUp()
        view = InformationViewMock()
        sut = InformationViewController(view: view)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        view = nil
    }

    func testThatCheckSettingDelegateCollectionView() {
        // act
        sut.viewDidLoad()

        // assert
        XCTAssertTrue(view.setDelegateCollectionViewWasCalled)
    }

    func testThatCheckRefundableCountCollectionViewItems() {
        // arrange
        let count = 5
        let symptomsCollection = Array(repeating: "test", count: count)
        sut = InformationViewController(view: view, symptomsCollection: symptomsCollection)

        // act
        let res = sut.collectionView(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()),
                                     numberOfItemsInSection: 0)

        // assert
        XCTAssertEqual(res, count)
    }
}
