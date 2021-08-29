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
    func setNavigationControllers(statisticsNavigation: UINavigationController, informationNavigation: UINavigationController)
    func openActivityViewController(activityViewController: UIActivityViewController)
    func openCountryListViewController(controller: ICountryListViewController)
    func closeCountryListViewController()
}

final class MainRouter: IMainRouter {
    var tabBarController: UITabBarController
    
    private weak var statisticsNavViewController: UINavigationController?
    private weak var informationNavViewController: UINavigationController?
    
    // MARK: - Initialization
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    // MARK: - IMainRouter

    func setNavigationControllers(statisticsNavigation: UINavigationController, informationNavigation: UINavigationController) {
        statisticsNavViewController = statisticsNavigation
        informationNavViewController = informationNavigation
    }

    func openActivityViewController(activityViewController: UIActivityViewController) {
        statisticsNavViewController?.present(activityViewController, animated: true, completion: nil)
    }

    func openCountryListViewController(controller: ICountryListViewController) {
        guard let viewController = controller as? UIViewController else { return }
        statisticsNavViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func closeCountryListViewController() {
        statisticsNavViewController?.dismiss(animated: true, completion: nil)
    }
}
