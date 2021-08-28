//
//  NetworkingService.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 20.08.2021.
//

import Foundation

protocol INetworkingService {
    var statisticsHandler: ((Result<CountryStatisticsModel, NetworkServiceError>) -> Void)? { get set }
    func fetchDataByCountry(codeCurrentCountry: String?)
}

class NetworkingService: INetworkingService {
    private let requestSender: IRequestSender
    private let dataMapper: IStatisticsDataMapper
    
    var statisticsHandler: ((Result<CountryStatisticsModel, NetworkServiceError>) -> Void)?

    // MARK: - Initialization
    
    init(requestSender: IRequestSender, dataMapper: IStatisticsDataMapper) {
        self.requestSender = requestSender
        self.dataMapper = dataMapper
    }
    
    // MARK: - Fetching data
    
    func fetchDataByCountry(codeCurrentCountry: String?) { // Check
        let codeCountry = codeCurrentCountry ?? DefaultCountryConstants.countryCode
        
        var countryImageResponse: CountryImageResponse?
        var countryResponse: CountryResponse?
        var errorResult = NetworkServiceError.unknown
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        
        let statisticsConfiguration = RequestsFactory.statisticsConfiguration(countryCode: codeCountry)
        requestSender.send(configuration: statisticsConfiguration) { (result: Result<CountryResponse, NetworkServiceError>) in
            switch result {
            case .success(let country):
                countryResponse = country
            case .failure(let error):
                errorResult = error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        
        let countryImageConfiguration = RequestsFactory.countryImageConfiguration(countryCode: codeCountry)
        requestSender.send(configuration: countryImageConfiguration) { (result: Result<CountryImageResponse, NetworkServiceError>) in
            switch result {
            case .success(let imageData):
                countryImageResponse = imageData
            case .failure(let error):
                // TODO change
                print(error)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.global()) {
            guard let countryResponse = countryResponse else {
                self.statisticsHandler?(.failure(errorResult))
                return
            }
            let countryStatistics = self.dataMapper.getStatisticsModelByCountry(statistics: countryResponse, countryImage: countryImageResponse)
            self.statisticsHandler?(.success(countryStatistics))
        }
    }
}

// MARK: - Errors

enum NetworkServiceError: Error {
    case incorrectUrl
    case networking
    case decoding
    case unknown

    var message: String {
        switch self {
        case .incorrectUrl:
            return "Использован некорректный URL. Повторите попытку позже."
        case .networking:
            return "Ошибка соединения. Повторите попытку позже."
        case .decoding:
            return "Ошибка получения данных. Повторите попытку позже."
        case .unknown:
            return "Неизвестная ошибка. Повторите попытку позже."
        }
    }
}
