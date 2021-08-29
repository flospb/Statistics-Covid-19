//
//  CountryListView.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 21.08.2021.
//

import UIKit

protocol ICountryListView {
    var delegate: ICountryListViewController? { get set }
    var countryListTableView: UITableView { get set }
    func setDelegates()
}

class CountryListView: UIView {
    var delegate: ICountryListViewController?
    var countryListTableView = UITableView()

    private let searchBarView = UISearchBar()
    private let anchorСonstant = CGFloat(10)
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
}
