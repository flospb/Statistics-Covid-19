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
}

class AssemblyBuilder: IAssemblyBuilder {
    
    // MARK: Tab bar
    
    func makeRootTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        let router = MainRouter(tabBarController: tabBarController)

        let statisticsViewController = makeStatisticsViewController(router: router)
        let statisticsNavViewController = makeStatisticsNavViewController(rootViewController: statisticsViewController)
        
        let informationViewController = makeInformationViewController()
        let informationNavViewController = makeInformationNavViewController(rootViewController: informationViewController)

        tabBarController.setViewControllers([statisticsNavViewController, informationNavViewController], animated: true)
        
        router.setNavigationControllers(statisticsNavigation: statisticsNavViewController,
                                        informationNavigation: informationNavViewController)
        
        return tabBarController
    }
    
    // MARK: Statistics
    
    private func makeStatisticsViewController(router: IMainRouter) -> UIViewController {
        let statisticsViewController = StatisticsViewController(router: router)
        statisticsViewController.view.backgroundColor = .cyan // test
        return statisticsViewController
    }
    
    private func makeStatisticsNavViewController(rootViewController: UIViewController) -> UINavigationController {
        let statisticsNavViewController = UINavigationController(rootViewController: rootViewController)
        statisticsNavViewController.tabBarItem.title = TabBarConstants.statisticsTitle
        statisticsNavViewController.tabBarItem.image = UIImage(systemName: TabBarConstants.statisticsImage)
        return statisticsNavViewController
    }

    // MARK: Information
    
    private func makeInformationViewController() -> UIViewController {
        let informationViewController = InformationViewController()
        informationViewController.view.backgroundColor = .yellow // test
        return informationViewController
    }
    
    private func makeInformationNavViewController(rootViewController: UIViewController) -> UINavigationController {
        let informationNavViewController = UINavigationController(rootViewController: rootViewController)
        informationNavViewController.tabBarItem.title = TabBarConstants.informationTitle
        informationNavViewController.tabBarItem.image = UIImage(systemName: TabBarConstants.informationImage)
        return informationNavViewController
    }
}
