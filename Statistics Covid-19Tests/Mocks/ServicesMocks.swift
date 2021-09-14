//
//  ServicesMocks.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 14.09.2021.
//

import Foundation
import UIKit
import CoreData

// MARK: - IImageStorageService

class ImageStorageServiceMock: IImageStorageService {
    var clearImageWasCalled = false

    func clearImage(imageName: String) {
        clearImageWasCalled = true
    }
    func saveImage(imageName: String, image: UIImage, completion: @escaping (ResultWorkingWithImage?) -> Void) {}
    func loadImage(imageName: String, completion: @escaping (UIImage?) -> Void) {}
}

// MARK: - IAssemblyBuilder

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

// MARK: - IMainRouter

class MainRouterMock: IMainRouter {
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

    var closeCountryListViewControllerWasCalled = false
    func closeCountryListViewController() {
        closeCountryListViewControllerWasCalled = true
    }

    func openCountryListViewController(controller: ICountryListViewController) {}
    func setNavigationControllers(statisticsNavigation: UINavigationController,
                                  informationNavigation: UINavigationController,
                                  vaccinationNavigation: UINavigationController) {}
}

// MARK: - INetworkingService

class NetworkingServiceMock: INetworkingService {
    func fetchDataByCountry(codeCurrentCountry: String?, completion: @escaping (Result<CountryStatisticsModel, NetworkingError>) -> Void) {}
}

// MARK: - IRequestSender

class RequestSenderMock: IRequestSender {
    func send<Parser>(configuration: Configuration<Parser>,
                      completion: @escaping (Result<Parser.Model, NetworkingError>) -> Void) where Parser: IParser {
        let countryData = CountryData(name: "", code: "", updateDate: "", totalData: nil, timeLine: [])
        let countryResponse = CountryResponse(data: countryData)

        if let model = countryResponse as? Parser.Model {
            completion(.success(model))
        } else {
            completion(.failure(.networking))
        }
    }
}

// MARK: - ICoreDataService

class CoreDataServiceMock: ICoreDataService {
    func getCountryList(completion: @escaping ([CountryModel]) -> Void) {}
    func getCountryStatistics(countryCode: String, completion: @escaping (CountryStatisticsModel) -> Void) {}
    func saveCountryStatistics(countryStatistics: CountryStatisticsModel) {}
}

// MARK: - IUserDefaultsService

class UserDefaultsMock: UserDefaults {
    var value: Any?
    var key: String?
    var transmittedValueSet = false
    var transmittedValueReceived = false

    override func setValue(_ value: Any?, forKey key: String) {
        transmittedValueSet = true
        self.value = value
        self.key = key
    }

    override func data(forKey key: String) -> Data? {
        transmittedValueReceived = true
        self.key = key
        return value as? Data
    }
}

class UserDefaultsServiceMock: IUserDefaultsService {
    func saveObject<T>(object: T, for key: String) where T: Encodable {}
    func getObject<T>(for key: String) -> T? where T: Decodable {
        return nil
    }
}

// MARK: - IStatisticsDataMapper

class DataMapperMock: IStatisticsDataMapper {
    func getCountryListByStorageModel(countries: [DBCountry]) -> [CountryModel] {
        return [CountryModel(code: "", name: "")]
    }

    func getStatisticsModelByCountry(statistics: CountryResponse, countryImage: CountryImageResponse?) -> CountryStatisticsModel {
        return CountryStatisticsModel(country: CurrentCountryModel(code: "RU", name: "Россия", image: nil))
    }

    func getStatisticsModelByStorageModel(statistics: DBStatistics) -> CountryStatisticsModel? {
        return nil
    }

    func getStatisticsStorageModel(statistics: CountryStatisticsModel,
                                   country: DBCountry, context: NSManagedObjectContext) -> DBStatistics {
        return DBStatistics()
    }
}

// MARK: - IUserDefaultsService

class DataFormatterMock: IDataFormatterService {
    func changeDateFormat(changedDate: String, oldFormat: String, newFormat: String) -> String? {
        return nil
    }

    func getDateFromString(format: String, date: String) -> Date? {
        return nil
    }

    func getStringDate(format: String, date: Date) -> String {
        return ""
    }

    func decimalFormatting(number: Int) -> String {
        return ""
    }
}
