//
//  StatisticsViewController.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 08.08.2021.
//

import UIKit

protocol IStatisticsViewController {
    // test
    var codeCurrentCountry: String? { get set }
    
    func countryTapped()
    func shareButtonTapped()
    func refreshButtonTapped()
}

class StatisticsViewController: UIViewController {
    private var router: IMainRouter
    private var statisticsView: IStatisticsView
    private var networkingService: INetworkingService
    private var userDefaultsService: IUserDefaultsService
    
    var codeCurrentCountry: String? // not private for test
    
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
        
        if let codeCountry: String? = userDefaultsService.getObject(for: DefaultCountryConstants.valueKey) {
            codeCurrentCountry = codeCountry
        }
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // MARK: - Helpers
    
    private func showAlert(for error: NetworkServiceError) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: AlertConstants.alertTitle, message: error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: AlertConstants.alertActionOk, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

// MARK: - IStatisticsViewController

extension StatisticsViewController: IStatisticsViewController {
    func countryTapped() {
        // TODO Open new VC
        loadData()
    }
    
    func shareButtonTapped() {
        print("Share tapped")
        router.openTestVC(VC: self)
    }
    
    func refreshButtonTapped() {
        loadData()
    }
    
    // MARK: - Loading data
    
    func loadData() {
        guard let codeCountry = codeCurrentCountry else {
            loadCountries()
            return
        }
        userDefaultsService.saveObject(object: codeCurrentCountry, for: DefaultCountryConstants.valueKey) // test
        loadStatisticsByCountry(countryCode: codeCountry)
        loadCountryImage(countryCode: codeCountry, countryImageName: AdressesAPIConstants.countryImageName)
    }
    
    private func loadCountries() {
        networkingService.fetchCountriesList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.userDefaultsService.saveObject(object: DefaultCountryConstants.countryCode, for: DefaultCountryConstants.valueKey)
                self.loadStatisticsByCountry(countryCode: DefaultCountryConstants.countryCode)
                self.loadCountryImage(countryCode: DefaultCountryConstants.countryCode, countryImageName: AdressesAPIConstants.countryImageName)
            case .failure(let error):
                self.showAlert(for: error)
            }
        }
    }
    
    private func loadStatisticsByCountry(countryCode: String) {
        networkingService.fetchStatisticsByCountry(countryCode: countryCode) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let country):
                DispatchQueue.main.async {
                    self.statisticsView.fillCountryData(country: country.data.name, image: nil)
                }
            case .failure(let error):
                self.showAlert(for: error)
            }
        }
    }
    
    private func loadCountryImage(countryCode: String, countryImageName: String) {
        networkingService.fetchCountryImage(countryCode: countryCode, countryImageName: countryImageName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let imageData):
                print(imageData)
                self.setCountryImage(imageData: imageData.data)
            case .failure(let error):
                self.showAlert(for: error)
            }
        }
    }
    
    private func setCountryImage(imageData: Data) {
        if let image = UIImage(data: imageData) {
            DispatchQueue.main.async {
                self.statisticsView.fillCountryData(country: nil, image: image)
            }
        }
    }
}
