//
//  StatisticsControllerMocks.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 14.09.2021.
//

import Foundation

class StatisticsViewMock: IStatisticsView {
    var delegate: IStatisticsViewController?

    func fillCountryData(countryStatistics: CountryStatisticsModel, dataFormatter: IDataFormatterService) {}
    func updateStatActivityIndicator(run: Bool) {}
}
