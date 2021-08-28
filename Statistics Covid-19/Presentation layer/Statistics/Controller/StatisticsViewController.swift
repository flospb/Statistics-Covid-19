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
    private var coreDataService: ICoreDataService
    private var userDefaultsService: IUserDefaultsService
    
    private var codeCurrentCountry: String?
    private var countryList = [CountryModel]() // TODO check
    private var defaultCountryCode = StatisticsConstants.defaultCountryCode
    
    // MARK: - Initialization

    // change format parameters
    init(router: IMainRouter,
         view: IStatisticsView,
         networkingService: INetworkingService,
         coreDataService: ICoreDataService,
         userDefaultsService: IUserDefaultsService) {

        self.router = router
        self.statisticsView = view
        self.networkingService = networkingService
        self.coreDataService = coreDataService
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
    
        if let codeCountry: String = userDefaultsService.getObject(for: DefaultCountryConstants.valueKey) {
            codeCurrentCountry = codeCountry
        }
        
        networkingService.statisticsHandler = statisticsHandler
        downloadDataFromStorage()
        loadStatisticsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Loading data
    
    private func loadStatisticsData() {
         return
        if codeCurrentCountry == nil {
            fillCountryList()
        } else {
            networkingService.fetchDataByCountry(codeCurrentCountry: codeCurrentCountry)
        }
    }

    private func fillCountryList() {
        coreDataService.getCountryList { [weak self] result in
            self?.countryList = result
            self?.networkingService.fetchDataByCountry(codeCurrentCountry: self?.defaultCountryCode)
        }
    }

    // MARK: - Storage

    private func downloadDataFromStorage() {
        let codeCountry: String
        if let code = codeCurrentCountry {
            codeCountry = code
        } else {
            codeCountry = defaultCountryCode
        }

        if countryList.count == 0 {
            coreDataService.getCountryList { [weak self] result in
                self?.countryList = result
            }
        }

        coreDataService.getCountryStatistics(countryCode: codeCountry) { result in
            self.statisticsView.fillCountryData(countryStatistics: result, dataFormatter: DataFormatterService())
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
                self.saveDataToStorage(countryStatistics: countryStatistics)
            }
        case .failure(let error):
            self.showAlert(for: error)
        }
    }

    private func countrySelectionHandler(countryCode: String) {
        self.codeCurrentCountry = countryCode
        userDefaultsService.saveObject(object: countryCode, for: DefaultCountryConstants.valueKey)
        markSelectedCountry(code: countryCode)
        downloadDataFromStorage()
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

    private func markSelectedCountry(code: String) {
        guard let selected = countryList.firstIndex(where: { $0.code == code }),
             let previouslySelected = countryList.firstIndex(where: { $0.selected }) else { return }

        countryList[selected].selected = true
        countryList[previouslySelected].selected = false
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
        countryList.removeAll()
        loadStatisticsData()
    }
}
