//
//  CoreDataServiceMocks.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 14.09.2021.
//

import Foundation

class CoreDataServiceMock: ICoreDataService {
    func getCountryList(completion: @escaping ([CountryModel]) -> Void) {}
    func getCountryStatistics(countryCode: String, completion: @escaping (CountryStatisticsModel) -> Void) {}
    func saveCountryStatistics(countryStatistics: CountryStatisticsModel) {}
}
