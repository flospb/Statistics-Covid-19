//
//  CountryListViewController.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 21.08.2021.
//

import UIKit

protocol ICountryListViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
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

        let showName = UIResponder.keyboardDidShowNotification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: showName, object: nil)

        let hideName = UIResponder.keyboardWillHideNotification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHide(_:)), name: hideName, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    // MARK: - Actions

    @objc func keyboardWasShown(_ notification: NSNotification) {
        if let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            countryListView.tableViewUp(keyboardHeight: keyboardRect.height)
        }
    }

    @objc func keyboardWillBeHide(_ notification: NSNotification) {
        countryListView.tableViewDown()
    }

    // MARK: - Private

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
        delegateHandler?(country.code)
        router.closeCountryListViewController()
    }

    // MARK: - Search bar

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCountryList = countryList
        if !searchText.isEmpty {
            filteredCountryList = filteredCountryList.filter({ $0.name.contains(searchBar.text ?? "") })
        }
        countryListView.reloadTableView()
    }
}
