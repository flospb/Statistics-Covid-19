//
//  CountryListViewController.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 21.08.2021.
//

import UIKit

protocol ICountryListViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate { // TODO check
    var delegateHandler: ((_ countryCode: String) -> Void)? { get set }
}

class CountryListViewController: UIViewController {

    // MARK: - Dependencies

    var delegateHandler: ((String) -> Void)?
    private var router: IMainRouter
    private var countryListView: ICountryListView

    // MARK: - Models

    private var countryList = [CountryListModel]()
    private var filteredCountryList = [CountryListModel]()
    private let cellId = CellNames.countryListTableCell
    
    // MARK: - Initialization
    
    init(router: IMainRouter, view: ICountryListView, countryList: [CountryModel], countryCode: String) {
        self.router = router
        self.countryListView = view
        super.init(nibName: nil, bundle: nil)
        self.fillCountyList(countries: countryList, countryCode: countryCode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = countryListView as? UIView
        countryListView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryListView.setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    // MARK: - Helpers

    private func fillCountyList(countries: [CountryModel], countryCode: String) {
        countries.forEach { country in
            let selected = countryCode == country.code
            let countryListModel = CountryListModel(name: country.name, code: country.code, selected: selected)
            countryList.append(countryListModel)
        }
        filteredCountryList = countryList
    }
}

// MARK: - ICountryListViewController

extension CountryListViewController: ICountryListViewController {
    
    // MARK: - Table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCountryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as? CountryListTableViewCell else {
            return UITableViewCell()
        }
        let country = filteredCountryList[indexPath.row]
        cell.configureCell(countryName: country.name, selected: country.selected)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = filteredCountryList[indexPath.row]
        router.closeCountryListViewController()
        delegateHandler?(country.code)
    }
    
    // MARK: - Search bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCountryList = countryList
        if !searchText.isEmpty {
            filteredCountryList = filteredCountryList.filter({$0.name.contains(searchBar.text ?? "")})
        }
        countryListView.countryListTableView.reloadData()
    }
}
