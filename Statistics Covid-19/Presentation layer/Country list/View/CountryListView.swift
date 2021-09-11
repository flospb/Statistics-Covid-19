//
//  CountryListView.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 21.08.2021.
//

import UIKit

protocol ICountryListView {
    var delegate: ICountryListViewController? { get set }
    func reloadTableView()
    func setDelegates()
    func tableViewUp(keyboardHeight: CGFloat)
    func tableViewDown()
}

class CountryListView: UIView {

    // MARK: - Dependencies

    var delegate: ICountryListViewController?

    // MARK: - UI

    private let countryListTableView = UITableView()
    private let searchBarView = UISearchBar()

    // MARK: - Models

    private let anchorСonstant: CGFloat = 10

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)
        settingView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setting view

    private func settingView() {
        self.backgroundColor = .systemBackground

        addSearchBarView()
        addCountryListTableView()
    }

    private func addSearchBarView() {
        searchBarView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(searchBarView)
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: anchorСonstant),
            searchBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: anchorСonstant),
            searchBarView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -anchorСonstant)
        ])
    }

    private func addCountryListTableView() {
        countryListTableView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(countryListTableView)
        NSLayoutConstraint.activate([
            countryListTableView.topAnchor.constraint(equalTo: self.searchBarView.bottomAnchor, constant: anchorСonstant),
            countryListTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: anchorСonstant),
            countryListTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -anchorСonstant),
            countryListTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -anchorСonstant)
        ])
    }

}

// MARK: - ICountryListView

extension CountryListView: ICountryListView {
    func setDelegates() {
        guard let controller = delegate else { return }
        searchBarView.delegate = controller

        countryListTableView.delegate = controller
        countryListTableView.dataSource = controller
        countryListTableView.register(CountryListTableViewCell.self, forCellReuseIdentifier: CellNames.countryListTableCell)
    }

    func reloadTableView() {
        countryListTableView.reloadData()
    }

    func tableViewUp(keyboardHeight: CGFloat) {
        let bottom = keyboardHeight - self.safeAreaInsets.bottom
        let edgeInsets: UIEdgeInsets = .init(top: 0, left: 0, bottom: bottom, right: 0)

        countryListTableView.contentInset = edgeInsets
        countryListTableView.scrollIndicatorInsets = edgeInsets
    }

    func tableViewDown() {
        countryListTableView.contentInset = .zero
        countryListTableView.scrollIndicatorInsets = .zero
    }
}
