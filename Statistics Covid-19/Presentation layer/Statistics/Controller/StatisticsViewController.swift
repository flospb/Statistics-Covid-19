//
//  StatisticsViewController.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 08.08.2021.
//

import UIKit

protocol IStatisticsViewController {
    func countryTapped()
    func shareButtonTapped()
    func refreshButtonTapped()
}

class StatisticsViewController: UIViewController {
    private var router: IMainRouter
    private var statisticsView: IStatisticsView
    private var networkingService: INetworkingService
    private var userDefaultsService: IUserDefaultsService
    
    private var codeCurrentCountry: String?
    private var countryList = [CountryModel]() // TODO check
    private var defaultCountryCode = StatisticsConstants.defaultCountryCode
    
    // MARK: - Initialization
    
    init(router: IMainRouter, view: IStatisticsView, networkingService: INetworkingService) {
        self.router = router
        self.statisticsView = view
        self.networkingService = networkingService
        self.userDefaultsService = UserDefaultsService() // TODO Check
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
    
        if let codeCountry: String = userDefaultsService.getObject(for: DefaultCountryConstants.valueKey) {
            codeCurrentCountry = codeCountry
        }
        
        networkingService.statisticsHandler = statisticsHandler
        loadStatisticsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Loading data
    
    func loadStatisticsData() {
        if codeCurrentCountry == nil {
            fillCountryList()
        }
        networkingService.fetchDataByCountry(codeCurrentCountry: codeCurrentCountry)
    }
    
    // MARK: - Handlers
    
    private func statisticsHandler(result: Result<CountryStatisticsModel, NetworkServiceError>) {
        switch result {
        case .success(let countryStatistics):
            DispatchQueue.main.async {
                self.statisticsView.fillCountryData(countryStatistics: countryStatistics)
            }
        case .failure(let error):
            self.showAlert(for: error)
        }
    }

    private func countrySelectionHandler(countryCode: String) {
        self.codeCurrentCountry = countryCode
        userDefaultsService.saveObject(object: countryCode, for: DefaultCountryConstants.valueKey)
        // TODO selected country
        loadStatisticsData()
    }
    
    // MARK: - Helpers
    
    private func showAlert(for error: NetworkServiceError) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: AlertConstants.alertTitle, message: error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: AlertConstants.alertActionOk, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    private func fillCountryList() {
        let countryCodes = NSLocale.isoCountryCodes
        
        for code in countryCodes {
            guard let name = NSLocale(localeIdentifier: "RU").localizedString(forCountryCode: code) else { continue }
            let countrySelected = code == defaultCountryCode
            let country = CountryModel(name: name, code: code, selected: countrySelected)
            countryList.append(country)
        }
    }
}

// MARK: - IStatisticsViewController

extension StatisticsViewController: IStatisticsViewController {
    
    // MARK: - View actions
    
    func countryTapped() {
        let countryListViewController = AssemblyBuilder().makeCountryListViewController(router: router, countryList: countryList)
        countryListViewController.delegateHandler = countrySelectionHandler
        router.openCountryListViewController(controller: countryListViewController)
    }
    
    func shareButtonTapped() {
        print("Share tapped")
    }
    
    func refreshButtonTapped() {
        loadStatisticsData()
    }
}
