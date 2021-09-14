//
//  AssemblyBuilderMocks.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 14.09.2021.
//

import Foundation
import UIKit

class AssemblyBuilderMock: IAssemblyBuilder {
    func makeRootTabBarController() -> UITabBarController {
        return UITabBarController()
    }

    func makeCountryListViewController(router: IMainRouter,
                                       countryList: [CountryModel],
                                       countryCode: String) -> ICountryListViewController {
        return CountryListViewController(coder: NSCoder())!
    }

    func makeActivityViewController(image: UIImage) -> UIActivityViewController {
        return UIActivityViewController(activityItemsConfiguration: UIActivityItemsConfiguration(objects: []))
    }

    func makeWebViewController(url: String) -> UIViewController {
        return UIViewController()
    }
}
