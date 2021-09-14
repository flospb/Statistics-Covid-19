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

class RequestSenderMock: IRequestSender {
    func send<Parser>(configuration: Configuration<Parser>,
                      completion: @escaping (Result<Parser.Model, NetworkingError>) -> Void) where Parser: IParser {
        let countryData = CountryData(name: "", code: "", updateDate: "", totalData: nil, timeLine: [])
        let countryResponse = CountryResponse(data: countryData)

        if let model = countryResponse as? Parser.Model {
            completion(.success(model))
        } else {
            completion(.failure(.networking))
        }
    }
}
