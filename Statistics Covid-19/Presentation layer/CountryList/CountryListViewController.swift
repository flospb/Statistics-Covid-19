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
    var delegateHandler: ((String) -> Void)?
    
    private var router: IMainRouter
    private var countryListView: ICountryListView
    
    private var countryList = [CountryModel]()
    private var filteredCountryList = [CountryModel]()
    
    private let cellId = CellNames.countryListTableCell
    
    // MARK: - Initialization
    
    init(router: IMainRouter, view: ICountryListView, countryList: [CountryModel]) {
        self.router = router
        self.countryListView = view
        self.filteredCountryList = countryList
        self.countryList = countryList
        super.init(nibName: nil, bundle: nil)
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
        var country = filteredCountryList[indexPath.row]
        country.selected = true
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
