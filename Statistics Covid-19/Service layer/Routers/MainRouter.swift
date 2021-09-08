//
//  MainRouter.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 08.08.2021.
//

import UIKit

protocol IMainRouter {
    func setNavigationControllers(statisticsNavigation: UINavigationController,
                                  informationNavigation: UINavigationController,
                                  vaccinationNavigation: UINavigationController)
    func openActivityViewController(activityViewController: UIActivityViewController)
    func openCountryListViewController(controller: ICountryListViewController)
    func closeCountryListViewController()
    func openWebViewController(controller: UIViewController)
    func openImagePickerController(controller: IVaccinationViewController)
}

final class MainRouter: IMainRouter {

    // MARK: - Dependencies

    private let tabBarController: UITabBarController

    private weak var statisticsNavViewController: UINavigationController?
    private weak var informationNavViewController: UINavigationController?
    private weak var vaccinationViewController: UINavigationController?

    // MARK: - Initialization

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    // MARK: - IMainRouter

    func setNavigationControllers(statisticsNavigation: UINavigationController,
                                  informationNavigation: UINavigationController,
                                  vaccinationNavigation: UINavigationController) {
        statisticsNavViewController = statisticsNavigation
        informationNavViewController = informationNavigation
        vaccinationViewController = vaccinationNavigation
    }

    // MARK: - Statistics

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

    // MARK: - Vaccination

    func openWebViewController(controller: UIViewController) {
        vaccinationViewController?.present(controller, animated: true, completion: nil)
    }

    func openImagePickerController(controller: IVaccinationViewController) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = controller
        vaccinationViewController?.present(imagePickerController, animated: true, completion: nil)
    }
}
