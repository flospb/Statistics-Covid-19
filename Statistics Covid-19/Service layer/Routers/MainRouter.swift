//
//  MainRouter.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 08.08.2021.
//

import Foundation
import UIKit

protocol IMainRouter {
    var tabBarController: UITabBarController { get }
    func openTestVC()
}

final class MainRouter: IMainRouter {
    var tabBarController: UITabBarController
    
    private weak var statisticsNavViewController: UINavigationController?
    private weak var informationNavViewController: UINavigationController?
    
    // MARK: Initialization
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func setNavigationControllers(statisticsNavigation: UINavigationController, informationNavigation: UINavigationController) {
        statisticsNavViewController = statisticsNavigation
        informationNavViewController = informationNavigation
    }
    
    // test
    func openTestVC() {
        let testVC = UIViewController()
        testVC.view.backgroundColor = .blue
        statisticsNavViewController?.pushViewController(testVC, animated: true)
    }
}
