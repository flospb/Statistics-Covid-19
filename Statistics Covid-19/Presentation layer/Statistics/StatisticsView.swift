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
    private let countryView = CountryView(frame: .zero, country: CountryModel(code: "RU", name: "Россия")) // test change
    
    private let newCasesView = NewCasesView(frame: .zero)
    private let totalCasesView = TotalCasesView(frame: .zero)

    private let anchorСonstant = CGFloat(20)
    private let doubleAnchorСonstant = CGFloat(40)
    
    private let buttonsStackView = UIStackView()
    private let shareButtonView = CommandButtonView(type: .system)
    private let refreshButtonView = CommandButtonView(type: .system)
    
    // private let activityIndicatorView = UIActivityIndicatorView()
    
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
        
        addStatisticsViewTitle()
        addCountryView()
        addNewCasesView()
        addTotalCasesView()
        addButtonsStackView()
        
        settingShareButtonView()
        settingRefreshButtonView()
    }
    
    private func addStatisticsViewTitle() {
        statisticsViewTitle.translatesAutoresizingMaskIntoConstraints = false
        statisticsViewTitle.text = StatisticsConstants.statisticsTitle
        statisticsViewTitle.font = FontConstants.largeBoldTitle
        // statisticsViewTitle.backgroundColor = .systemGray // test
        
        self.addSubview(statisticsViewTitle)
            
        NSLayoutConstraint.activate([
            statisticsViewTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: anchorСonstant),
            statisticsViewTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: anchorСonstant),
            statisticsViewTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -anchorСonstant)
        ])
    }
    
    private func addCountryView() {
        countryView.translatesAutoresizingMaskIntoConstraints = false
        // countryView.backgroundColor = .systemGreen // test
        
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
        // newCasesView.backgroundColor = .yellow // test
    
        self.addSubview(newCasesView)
            
        NSLayoutConstraint.activate([
            newCasesView.topAnchor.constraint(equalTo: countryView.bottomAnchor, constant: anchorСonstant),
            newCasesView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: anchorСonstant),
            newCasesView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -anchorСonstant)
        ])
    }
    
    private func addTotalCasesView() {
        totalCasesView.translatesAutoresizingMaskIntoConstraints = false
        // totalCasesView.backgroundColor = .green // test
    
        self.addSubview(totalCasesView)
            
        NSLayoutConstraint.activate([
            totalCasesView.topAnchor.constraint(equalTo: newCasesView.bottomAnchor, constant: doubleAnchorСonstant),
            totalCasesView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: anchorСonstant),
            totalCasesView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -anchorСonstant)
        ])
    }
    
    private func addButtonsStackView() {
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        // buttonsStackView.backgroundColor = .green // test
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = anchorСonstant
        buttonsStackView.distribution = .fillEqually
    
        buttonsStackView.addArrangedSubview(shareButtonView)
        buttonsStackView.addArrangedSubview(refreshButtonView)
        
        self.addSubview(buttonsStackView)
            
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: totalCasesView.bottomAnchor, constant: doubleAnchorСonstant),
            buttonsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: anchorСonstant),
            buttonsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -anchorСonstant),
            buttonsStackView.heightAnchor.constraint(equalToConstant: doubleAnchorСonstant)
        ])
    }
    
    private func settingShareButtonView() {
        shareButtonView.addTarget(self, action: #selector(shareButtonViewAction(_:)), for: .touchUpInside)
        shareButtonView.settingView(title: StatisticsConstants.shareTitle,
                                      titleColor: UIColor.darkText,
                                      backgroundColor: ColorsConstants.shareBackground,
                                      imageName: "Share")
    }
    
    private func settingRefreshButtonView() {
        refreshButtonView.addTarget(self, action: #selector(refreshButtonViewAction(_:)), for: .touchUpInside)
        refreshButtonView.settingView(title: StatisticsConstants.refreshTitle,
                                      titleColor: UIColor.white,
                                      backgroundColor: ColorsConstants.refreshBackground,
                                      imageName: "Refresh")
    }
    
    // MARK: - Actions
    
    @objc func countryTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        delegate?.countryTapped()
    }
    
    @objc private func shareButtonViewAction(_ sender: UIButton) {
        delegate?.shareButtonTapped()
    }
    
    @objc private func refreshButtonViewAction(_ sender: UIButton) {
        delegate?.refreshButtonTapped()
    }
}

// MARK: - IStatisticsView

extension StatisticsView: IStatisticsView {} // TODO
