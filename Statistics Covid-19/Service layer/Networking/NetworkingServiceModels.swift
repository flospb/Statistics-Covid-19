//
//  NetworkingServiceModels.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 20.08.2021.
//

import Foundation

// MARK: - Country list

struct CountriesResponse: Decodable {
    let data: [CountryDescription]
}

struct CountryDescription: Decodable {
    let name: String
    let code: String
}

// MARK: - Country statistics

struct CountryResponse: Decodable {
    let data: CountryData
}

struct CountryData: Decodable {
    let name: String
    let code: String
    let updateDate: String
    let totalData: TotalData?
    let timeLine: [TimeLine]
    
    private enum CodingKeys: String, CodingKey {
        case name
        case code
        case updateDate = "updatedAt"
        case totalData = "latestData"
        case timeLine = "timeline"
    }
}

struct TotalData: Decodable {
    let deaths: Int?
    let confirmed: Int?
    let recovered: Int?
    let critical: Int?
}

struct TimeLine: Decodable {
    let date: String
    let newConfirmed: Int?
}

// MARK: - Country image

struct CountryImageResponse {
    let data: Data
}
