//
//  MainRouterMock.swift
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

    var openCountryListViewControllerWasCalled = false
    func openCountryListViewController(controller: ICountryListViewController) {
        openCountryListViewControllerWasCalled = true
    }

    func closeCountryListViewController() {}

    func openWebViewController(controller: UIViewController) {}

    func openImagePickerController(controller: IVaccinationViewController) {}
}
