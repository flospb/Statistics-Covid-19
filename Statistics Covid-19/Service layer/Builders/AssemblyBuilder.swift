//
//  AssemblyBuilder.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 08.08.2021.
//

import Foundation
import UIKit

protocol IAssemblyBuilder {
    func makeRootTabBarController() -> UITabBarController
    func makeCountryListViewController(router: IMainRouter, countryList: [CountryModel], countryCode: String) -> ICountryListViewController
}

class AssemblyBuilder: IAssemblyBuilder {
    
    // MARK: - Tab bar
    
    func makeRootTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        let router = MainRouter(tabBarController: tabBarController)

        let statisticsViewController = makeStatisticsViewController(router: router)
        let statisticsNavViewController = makeStatisticsNavViewController(rootViewController: statisticsViewController)
        
        let informationViewController = makeInformationViewController(router: router)
        let informationNavViewController = makeInformationNavViewController(rootViewController: informationViewController)

        tabBarController.setViewControllers([statisticsNavViewController, informationNavViewController], animated: true)
        
        router.setNavigationControllers(statisticsNavigation: statisticsNavViewController,
                                        informationNavigation: informationNavViewController)
        
        return tabBarController
    }
    
    // MARK: - Statistics
    
    private func makeStatisticsViewController(router: IMainRouter) -> UIViewController {
        let statisticsView = StatisticsView(frame: UIScreen.main.bounds)

        let dataFormatterService = DataFormatterService()
        let dataMapper = StatisticsDataMapper(dataFormatterService: dataFormatterService)

        let requestSender = RequestSender()
        let networkingService = NetworkingService(requestSender: requestSender, dataMapper: dataMapper)

        let coreDataStack = CoreDataStack()
        let coreDataService = CoreDataService(coreDataStack: coreDataStack, dataMapper: dataMapper)

        let userDefaults = UserDefaultsService()

        let statisticsViewController = StatisticsViewController(router: router,
                                                                view: statisticsView,
                                                                networkingService: networkingService,
                                                                coreDataService: coreDataService,
                                                                userDefaultsService: userDefaults)
        return statisticsViewController
    }
    
    private func makeStatisticsNavViewController(rootViewController: UIViewController) -> UINavigationController {
        let statisticsNavViewController = UINavigationController(rootViewController: rootViewController)
        statisticsNavViewController.tabBarItem.title = TabBarConstants.statisticsTitle
        statisticsNavViewController.tabBarItem.image = UIImage(systemName: TabBarConstants.statisticsImage)
        return statisticsNavViewController
    }

    // MARK: - Information
    
    private func makeInformationViewController(router: IMainRouter) -> UIViewController {
        let informationView = InformationView(frame: UIScreen.main.bounds)
        let informationViewController = InformationViewController(router: router, view: informationView)
        return informationViewController
    }
    
    private func makeInformationNavViewController(rootViewController: UIViewController) -> UINavigationController {
        let informationNavViewController = UINavigationController(rootViewController: rootViewController)
        informationNavViewController.isNavigationBarHidden = true
        informationNavViewController.tabBarItem.title = TabBarConstants.informationTitle
        informationNavViewController.tabBarItem.image = UIImage(systemName: TabBarConstants.informationImage)
        return informationNavViewController
    }
    
    // MARK: - Country list
    
    func makeCountryListViewController(router: IMainRouter,
                                       countryList: [CountryModel],
                                       countryCode: String) -> ICountryListViewController {
        let countryListView = CountryListView(frame: UIScreen.main.bounds)
        let countryListViewController = CountryListViewController(router: router,
                                                                  view: countryListView,
                                                                  countryList: countryList,
                                                                  countryCode: countryCode)
        return countryListViewController
    }
}
