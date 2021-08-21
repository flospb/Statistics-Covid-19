//
//  NetworkingService.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 20.08.2021.
//

protocol INetworkingService {
    func fetchCountriesList(completion: @escaping (Result<CountriesResponse, NetworkServiceError>) -> Void)
    func fetchStatisticsByCountry(countryCode: String, completion: @escaping (Result<CountryResponse, NetworkServiceError>) -> Void)
    func fetchCountryImage(countryCode: String, countryImageName: String, completion: @escaping (Result<CountryImageResponse, NetworkServiceError>) -> Void)
}

class NetworkingService: INetworkingService {
    private let requestSender: IRequestSender
    
    // MARK: - Initialization
    
    init(requestSender: IRequestSender) {
        self.requestSender = requestSender
    }
    
    // MARK: - Fetching data
    
    func fetchCountriesList(completion: @escaping (Result<CountriesResponse, NetworkServiceError>) -> Void) {
        let requestConfiguration = RequestsFactory.countryDescriptionConfiguration()
        requestSender.send(configuration: requestConfiguration) { (result: Result<CountriesResponse, NetworkServiceError>) in
            completion(result)
        }
    }
    
    func fetchStatisticsByCountry(countryCode: String, completion: @escaping (Result<CountryResponse, NetworkServiceError>) -> Void) {
        let requestConfiguration = RequestsFactory.statisticsConfiguration(countryCode: countryCode)
        requestSender.send(configuration: requestConfiguration) { (result: Result<CountryResponse, NetworkServiceError>) in
            completion(result)
        }
    }
    
    func fetchCountryImage(countryCode: String, countryImageName: String, completion: @escaping (Result<CountryImageResponse, NetworkServiceError>) -> Void) {
        let requestConfiguration = RequestsFactory.countryImageConfiguration(countryCode: countryCode, countryImageName: countryImageName)
        requestSender.send(configuration: requestConfiguration) { (result: Result<CountryImageResponse, NetworkServiceError>) in
            completion(result)
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
