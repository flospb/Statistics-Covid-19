//
//  StatisticsView.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 14.08.2021.
//

import UIKit

protocol IStatisticsView {
    var delegate: IStatisticsViewController? { get set }
}

class StatisticsView: UIView {
    var delegate: IStatisticsViewController?
    
    private let statisticsViewTitle = UILabel()
    private let countryView = CountryView(frame: .zero, country: CountryModel(code: "RU", name: "Россия"))
    
    private let newCasesView = NewCasesView(frame: .zero)

    private let anchorСonstant = CGFloat(20)
    
    private let refreshButtonView = UIButton(type: .system)
    
    private let activityIndicatorView = UIActivityIndicatorView()
    
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
        self.backgroundColor = .cyan
        
        addStatisticsViewTitle()
        addCountryView()
        addNewCasesView()
    }
    
    private func addStatisticsViewTitle() {
        statisticsViewTitle.translatesAutoresizingMaskIntoConstraints = false
        statisticsViewTitle.text = StatisticsConstants.statisticsTitle
        statisticsViewTitle.font = FontConstants.largeBoldTitle
        
        statisticsViewTitle.backgroundColor = .systemGray // test
        
        self.addSubview(statisticsViewTitle)
            
        NSLayoutConstraint.activate([
            statisticsViewTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            statisticsViewTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: anchorСonstant),
            statisticsViewTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -anchorСonstant)
        ])
    }
    
    private func addCountryView() {
        countryView.translatesAutoresizingMaskIntoConstraints = false
        
        countryView.backgroundColor = .systemGreen // test
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(countryTapped(tapGestureRecognizer:)))
        countryView.addGestureRecognizer(tapGestureRecognizer)
        
        self.addSubview(countryView)
            
        NSLayoutConstraint.activate([
            countryView.topAnchor.constraint(equalTo: statisticsViewTitle.bottomAnchor, constant: anchorСonstant),
            countryView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: anchorСonstant)
        ])
    }
    
    private func addNewCasesView() {
        newCasesView.translatesAutoresizingMaskIntoConstraints = false
        newCasesView.backgroundColor = .cyan // test
    
        self.addSubview(newCasesView)
            
        NSLayoutConstraint.activate([
            newCasesView.topAnchor.constraint(equalTo: countryView.bottomAnchor, constant: anchorСonstant),
            newCasesView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: anchorСonstant),
            newCasesView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -anchorСonstant)
        ])
    }
    
    // MARK: - Actions
    
    @objc func countryTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        print("Gusi")
    }
}

// MARK: - IStatisticsView

extension StatisticsView: IStatisticsView {}
