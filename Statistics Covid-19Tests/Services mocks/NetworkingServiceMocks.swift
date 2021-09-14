//
//  NetworkingServiceMocks.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 14.09.2021.
//

import Foundation

class NetworkingServiceMock: INetworkingService {
    func fetchDataByCountry(codeCurrentCountry: String?, completion: @escaping (Result<CountryStatisticsModel, NetworkingError>) -> Void) {}
}
