//
//  CountryListControllerMocks.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 14.09.2021.
//

import Foundation
import UIKit

class CountryListViewMock: ICountryListView {
    var delegate: ICountryListViewController?

    func reloadTableView() {}
    func setDelegates() {}
    func tableViewUp(keyboardHeight: CGFloat) {}
    func tableViewDown() {}
}
