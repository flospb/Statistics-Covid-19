//
//  AssemblyBuilder.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 08.08.2021.
//

import UIKit

protocol IAssemblyBuilder {
    func makeRootTabBarController() -> UITabBarController
    func makeCountryListViewController(router: IMainRouter, countryList: [CountryModel], countryCode: String) -> ICountryListViewController
    func makeActivityViewController(image: UIImage) -> UIActivityViewController
}

class AssemblyBuilder: IAssemblyBuilder {

    // MARK: - Tab bar

    func makeRootTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        let router = MainRouter(tabBarController: tabBarController)

        let statisticsViewController = makeStatisticsViewController(router: router)
        let statisticsNavViewController = makeStatisticsNavViewController(rootViewController: statisticsViewController)

        let vaccinationViewController = makeVaccinationViewController(router: router)
        let vaccinationNavViewController = makeVaccinationNavViewController(rootViewController: vaccinationViewController)

        let informationViewController = makeInformationViewController(router: router)
        let informationNavViewController = makeInformationNavViewController(rootViewController: informationViewController)

        let viewControllers = [statisticsNavViewController, vaccinationNavViewController, informationNavViewController]
        tabBarController.setViewControllers(viewControllers, animated: true)

        router.setNavigationControllers(statisticsNavigation: statisticsNavViewController,
                                        informationNavigation: informationNavViewController,
                                        vaccinationNavigation: vaccinationNavViewController)

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

        let builder = AssemblyBuilder()
        let userDefaults = UserDefaultsService()

        let statisticsViewController = StatisticsViewController(view: statisticsView,
                                                                router: router,
                                                                networkingService: networkingService,
                                                                coreDataService: coreDataService,
                                                                builder: builder,
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

    // MARK: - Vaccination

    private func makeVaccinationViewController(router: IMainRouter) -> UIViewController {
        let vaccinationView = VaccinationView(frame: UIScreen.main.bounds)
        let imageStorageService = ImageStorageService()
        let informationViewController = VaccinationViewController(view: vaccinationView,
                                                                  router: router,
                                                                  imageStorageService: imageStorageService)
        return informationViewController
    }

    private func makeVaccinationNavViewController(rootViewController: UIViewController) -> UINavigationController {
        let vaccinationNavViewController = UINavigationController(rootViewController: rootViewController)
        vaccinationNavViewController.isNavigationBarHidden = true
        vaccinationNavViewController.tabBarItem.title = TabBarConstants.vaccinationTitle
        vaccinationNavViewController.tabBarItem.image = UIImage(systemName: TabBarConstants.vaccinationImage)
        return vaccinationNavViewController
    }

    // MARK: - Share

    func makeActivityViewController(image: UIImage) -> UIActivityViewController {
        let items = [ImageActivityItemSource(image: image)]
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return activityViewController
    }
}
