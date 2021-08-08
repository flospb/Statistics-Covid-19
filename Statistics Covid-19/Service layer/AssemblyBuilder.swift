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
        let statisticsViewController = makeStatisticsViewController()
        let statisticsNavViewController = makeStatisticsNavViewController(rootViewController: statisticsViewController)
        
        let informationViewController = makeInformationViewController()
        let informationNavViewController = makeInformationNavViewController(rootViewController: informationViewController)
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([statisticsNavViewController, informationNavViewController], animated: true)
        
        return tabBarController
    }
    
    // MARK: Statistics
    
    private func makeStatisticsViewController() -> UIViewController {
        let statisticsViewController = StatisticsViewController()
        // test
        statisticsViewController.view.backgroundColor = .cyan
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
        let informationViewController = StatisticsViewController()
        informationViewController.view.backgroundColor = .blue
        return informationViewController
    }
    
    // MARK: Information
    
    private func makeInformationNavViewController(rootViewController: UIViewController) -> UINavigationController {
        let informationNavViewController = UINavigationController(rootViewController: rootViewController)
        informationNavViewController.tabBarItem.title = TabBarConstants.informationTitle
        informationNavViewController.tabBarItem.image = UIImage(systemName: TabBarConstants.informationImage)
        return informationNavViewController
    }
}
