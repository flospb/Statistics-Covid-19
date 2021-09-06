//
//  StatisticsViewController.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 08.08.2021.
//

import UIKit

protocol IStatisticsViewController {
    func countryTapped()
    func shareButtonTapped(image: UIImage)
    func refreshButtonTapped()
}

class StatisticsViewController: UIViewController {

    // MARK: - Dependencies

    private var statisticsView: IStatisticsView
    private var router: IMainRouter
    private var networkingService: INetworkingService
    private var coreDataService: ICoreDataService
    private var builder: IAssemblyBuilder
    private var userDefaultsService: IUserDefaultsService

    // MARK: - Models

    private var countryList = [CountryModel]()
    private lazy var codeCurrentCountry: String = {
        if let codeCountry: String = userDefaultsService.getObject(for: DefaultCountryConstants.valueKey) {
            return codeCountry
        } else {
            return StatisticsConstants.defaultCountryCode
        }
    }()

    // MARK: - Initialization

    init(view: IStatisticsView,
         router: IMainRouter,
         networkingService: INetworkingService,
         coreDataService: ICoreDataService,
         builder: IAssemblyBuilder,
         userDefaultsService: IUserDefaultsService) {

        self.statisticsView = view
        self.router = router
        self.networkingService = networkingService
        self.coreDataService = coreDataService
        self.builder = builder
        self.userDefaultsService = userDefaultsService

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        self.view = statisticsView as? UIView
        statisticsView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        networkingService.statisticsHandler = statisticsHandler
        loadDataFromStorage()
        loadStatisticsData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // MARK: - Loading data

    private func loadStatisticsData() {
        statisticsView.updateStatActivityIndicator(run: true)
        if countryList.isEmpty {
            fillCountryList()
        } else {
            networkingService.fetchDataByCountry(codeCurrentCountry: codeCurrentCountry)
        }
    }

    private func fillCountryList() {
        coreDataService.getCountryList { [weak self] result in
            self?.countryList = result
            self?.networkingService.fetchDataByCountry(codeCurrentCountry: self?.codeCurrentCountry)
        }
    }

    private func loadDataFromStorage() {
        if countryList.isEmpty {
            coreDataService.getCountryList { [weak self] result in
                self?.countryList = result
            }
        }

        coreDataService.getCountryStatistics(countryCode: codeCurrentCountry) { [weak self] result in
            self?.statisticsView.fillCountryData(countryStatistics: result, dataFormatter: DataFormatterService())
            self?.codeCurrentCountry = result.country.code
        }
    }

    private func saveDataToStorage(countryStatistics: CountryStatisticsModel) {
        coreDataService.saveCountryStatistics(countryStatistics: countryStatistics)
    }

    // MARK: - Handlers

    private func statisticsHandler(result: Result<CountryStatisticsModel, NetworkServiceError>) {
        switch result {
        case .success(let countryStatistics):
            DispatchQueue.main.async {
                self.statisticsView.fillCountryData(countryStatistics: countryStatistics, dataFormatter: DataFormatterService())
                self.statisticsView.updateStatActivityIndicator(run: false)
                self.saveDataToStorage(countryStatistics: countryStatistics) // todo мб вынести из DQ
            }
        case .failure(let error):
            DispatchQueue.main.async {
                self.showAlert(for: error)
            }
        }
    }

    private func countrySelectionHandler(countryCode: String) {
        self.codeCurrentCountry = countryCode
        userDefaultsService.saveObject(object: countryCode, for: DefaultCountryConstants.valueKey)
        fillDefaultValues(code: countryCode)
        loadDataFromStorage()
        loadStatisticsData()
    }

    // MARK: - Helpers

    private func showAlert(for error: NetworkServiceError) {
        let alert = UIAlertController(title: AlertConstants.alertTitle, message: error.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AlertConstants.alertActionOk, style: .default, handler: nil))
        self.present(alert, animated: true)
        self.statisticsView.updateStatActivityIndicator(run: false)
    }

    private func fillDefaultValues(code: String) {
        guard let selected = countryList.firstIndex(where: { $0.code == code }) else { return }
        let countryModel = CurrentCountryModel(code: countryList[selected].code, name: countryList[selected].name, image: nil)
        let countryStatistics = CountryStatisticsModel(country: countryModel)
        self.statisticsView.fillCountryData(countryStatistics: countryStatistics, dataFormatter: DataFormatterService())
    }
}

// MARK: - IStatisticsViewController

extension StatisticsViewController: IStatisticsViewController {

    // MARK: - View actions

    func countryTapped() {
        let countryListViewController = builder.makeCountryListViewController(router: router,
                                                                        countryList: countryList,
                                                                        countryCode: codeCurrentCountry)
        countryListViewController.delegateHandler = countrySelectionHandler
        router.openCountryListViewController(controller: countryListViewController)
    }

    func shareButtonTapped(image: UIImage) {
        let activityController = builder.makeActivityViewController(image: image)
        router.openActivityViewController(activityViewController: activityController)
    }

    func refreshButtonTapped() {
        countryList.removeAll()
        loadStatisticsData()
    }
}
