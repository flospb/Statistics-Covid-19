//
//  RequestsFactory.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 20.08.2021.
//

import Foundation

protocol IRequest {
    var urlRequest: URLRequest? { get }
}

struct Configuration<Parser> where Parser: IParser {
    let request: IRequest
    let parser: Parser
}

// TODO Refactor IRequest

class StatisticsRequest: IRequest {
    var urlRequest: URLRequest?
    
    init(stringUrl: String) {
        guard let url = URL(string: stringUrl) else { return }
        self.urlRequest = URLRequest(url: url)
    }
}

class CountryImageRequest: IRequest {
    var urlRequest: URLRequest?
    
    init(stringUrl: String) {
        guard let url = URL(string: stringUrl) else { return }
        self.urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
    }
}

struct RequestsFactory {
    static func statisticsConfiguration(countryCode: String) -> Configuration<StatisticsParser> {
        let stringUrl = AdressesAPIConstants.statisticsByCountry + countryCode
        let request = StatisticsRequest(stringUrl: stringUrl)
        let parser = StatisticsParser()
        return Configuration<StatisticsParser>(request: request, parser: parser)
    }
    
    static func countryImageConfiguration(countryCode: String) -> Configuration<CountryImageParser> {
        let countryImageName = AdressesAPIConstants.countryImageName
        let stringUrl = AdressesAPIConstants.countryImage + countryCode + countryImageName
        let request = CountryImageRequest(stringUrl: stringUrl)
        let parser = CountryImageParser()
        return Configuration<CountryImageParser>(request: request, parser: parser)
    }
}
