//
//  Parsers.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 20.08.2021.
//

import Foundation

protocol IParser {
    associatedtype Model
    func parse(data: Data) -> Model?
}

class StatisticsParser: IParser {
    typealias Model = CountryResponse

    // MARK: - IParser

    func parse(data: Data) -> Model? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let statisticsResponse = try decoder.decode(Model.self, from: data)
            return statisticsResponse
        } catch {
            return nil
        }
    }
}

class CountryImageParser: IParser {
    typealias Model = CountryImageResponse

    // MARK: - IParser

    func parse(data: Data) -> Model? {
        let model: Model? = CountryImageResponse(data: data)
        return model
    }
}
