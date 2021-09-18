//
//  CountryListControllerTests.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 14.09.2021.
//

import XCTest

class CountryListControllerTests: XCTestCase {
    var sut: ICountryListViewController!
    var router: MainRouterMock!
    var view: CountryListViewMock!
    var countryListCount: Int!
    var searchCountryName: String!
    var countryList = [CountryModel]()

    override func setUp() {
        super.setUp()
        router = MainRouterMock()
        view = CountryListViewMock()

        countryListCount = 2
        searchCountryName = "Россия"
        countryList.append(CountryModel(code: "RU", name: "Россия"))
        countryList.append(CountryModel(code: "UA", name: "Украина"))
        sut = CountryListViewController(router: router, view: view, countryList: countryList, countryCode: "RU")
    }

    override func tearDown() {
        super.tearDown()
        router = nil
        view = nil
        sut = nil
    }

    func testThatCheckTableViewDidSelectRow() {
        // act
        sut.tableView?(UITableView(), didSelectRowAt: IndexPath(row: 1, section: 1))

        // assert
        XCTAssertTrue(router.closeCountryListViewControllerWasCalled)
    }

    func testThatCheckTableViewNumberOfRowsInSection() {
        // act
        let result = sut.tableView(UITableView(), numberOfRowsInSection: 1)

        // assert
        XCTAssertEqual(result, countryList.count)
    }

    func testThatCheckTheCorrectnessOfTheSearch() {
        // arrange
        let searchBar = UISearchBar()
        searchBar.text = searchCountryName

        // act
        sut.searchBar?(searchBar, textDidChange: searchCountryName)
        let filteredListCount = sut.tableView(UITableView(), numberOfRowsInSection: 1)

        // assert
        XCTAssertEqual(filteredListCount, 1)
    }
}
