//
//  MainRouterMocks.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 13.09.2021.
//

import Foundation
import UIKit

class MainRouterMock: IMainRouter {
    func setNavigationControllers(statisticsNavigation: UINavigationController,
                                  informationNavigation: UINavigationController,
                                  vaccinationNavigation: UINavigationController) {}
    var openActivityViewControllerWasCalled = false
    func openActivityViewController(activityViewController: UIActivityViewController) {
        openActivityViewControllerWasCalled = true
    }

    var openImagePickerControllerWasCalled = false
    func openImagePickerController(controller: IVaccinationViewController) {
        openImagePickerControllerWasCalled = true
    }

    var openWebViewControllerWasCalled = false
    func openWebViewController(controller: UIViewController = UIViewController()) {
        openWebViewControllerWasCalled = true
    }

    func openCountryListViewController(controller: ICountryListViewController) {}
    func closeCountryListViewController() {}
}
