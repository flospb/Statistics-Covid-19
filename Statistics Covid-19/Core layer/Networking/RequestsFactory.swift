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

struct RequestConfiguration<Parser> where Parser: IParser {
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

class CountryDescriptionRequest: IRequest {
    var urlRequest: URLRequest?
    
    init(stringUrl: String) {
        guard let url = URL(string: stringUrl) else { return }
        self.urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
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
    static func countryDescriptionConfiguration() -> RequestConfiguration<CountryListParser> {
        let stringUrl = AdressesAPIConstants.countryList
        let request = StatisticsRequest(stringUrl: stringUrl)
        let parser = CountryListParser()
        return RequestConfiguration<CountryListParser>(request: request, parser: parser)
    }
    
    static func statisticsConfiguration(countryCode: String) -> RequestConfiguration<StatisticsParser> {
        let stringUrl = AdressesAPIConstants.statisticsByCountry + countryCode
        let request = StatisticsRequest(stringUrl: stringUrl)
        let parser = StatisticsParser()
        return RequestConfiguration<StatisticsParser>(request: request, parser: parser)
    }
    
    static func countryImageConfiguration(countryCode: String, countryImageName: String) -> RequestConfiguration<CountryImageParser> {
        let stringUrl = AdressesAPIConstants.countryImage + countryCode + countryImageName
        let request = CountryImageRequest(stringUrl: stringUrl)
        let parser = CountryImageParser()
        return RequestConfiguration<CountryImageParser>(request: request, parser: parser)
    }
}
