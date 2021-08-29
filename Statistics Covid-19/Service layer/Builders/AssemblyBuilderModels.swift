//
//  AssemblyBuilderModels.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 29.08.2021.
//

protocol IStatisticsServiceFactory {
    var router: IMainRouter { get }
    var networkingService: INetworkingService { get }
    var coreDataService: ICoreDataService { get }
    var builder: IAssemblyBuilder { get }
    var userDefaultsService: IUserDefaultsService { get }
}

struct StatisticsServiceFactory: IStatisticsServiceFactory {
    var router: IMainRouter
    var networkingService: INetworkingService
    var coreDataService: ICoreDataService
    var builder: IAssemblyBuilder
    var userDefaultsService: IUserDefaultsService
}
