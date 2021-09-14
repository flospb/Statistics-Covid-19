//
//  ControllersMocks.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 13.09.2021.
//

import Foundation
import UIKit

// MARK: - IInformationView

class InformationViewMock: IInformationView {
    var delegate: IInformationViewController?
    var setDelegateCollectionViewWasCalled = false

    func setDelegateCollectionView() {
        setDelegateCollectionViewWasCalled = true
    }
}

// MARK: - IStatisticsView

class StatisticsViewMock: IStatisticsView {
    var delegate: IStatisticsViewController?

    func fillCountryData(countryStatistics: CountryStatisticsModel, dataFormatter: IDataFormatterService) {}
    func updateStatActivityIndicator(run: Bool) {}
}

// MARK: - IVaccinationView

class VaccinationViewMock: IVaccinationView {
    var delegate: IVaccinationViewController?
    var setImageWasCalled = false

    func setImage(image: UIImage) {
        setImageWasCalled = true
    }
}

// MARK: - ICountryListView

class CountryListViewMock: ICountryListView {
    var delegate: ICountryListViewController?

    func reloadTableView() {}
    func setDelegates() {}
    func tableViewUp(keyboardHeight: CGFloat) {}
    func tableViewDown() {}
}
