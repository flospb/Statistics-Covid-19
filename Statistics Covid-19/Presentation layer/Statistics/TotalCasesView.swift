//
//  TotalCasesView.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 15.08.2021.
//

import UIKit

class TotalCasesView: UIView {
    private let contentStackView = UIStackView()
    
    private let totalCasesViewTitle = UILabel()
    private let totalCasesView = UILabel()
   
    private let casesDetailsStackView = UIStackView()
    
    private let recoveredStackView = UIStackView()
    private let recoveredViewTitle = UILabel()
    private let recoveredView = UILabel()
    
    private let criticalStackView = UIStackView()
    private let criticalViewTitle = UILabel()
    private let criticalView = UILabel()
    
    private let deathsStackView = UIStackView()
    private let deathsViewTitle = UILabel()
    private let deathsView = UILabel()

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
        addContentStackView()
        addCasesDetailsStackView()
        
        settingCasesTodayViewTitle()
        settingTotalCasesView()
        
        settingRecoveredViews()
        settingCriticalViews()
        settingDeathsViews()
    }

    private func addContentStackView() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical
        contentStackView.spacing = 5.0
        contentStackView.alignment = .fill
    
        contentStackView.addArrangedSubview(totalCasesViewTitle)
        contentStackView.addArrangedSubview(totalCasesView)
        contentStackView.addArrangedSubview(casesDetailsStackView)
        
        self.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func settingCasesTodayViewTitle() {
        totalCasesViewTitle.translatesAutoresizingMaskIntoConstraints = false
        totalCasesViewTitle.text = StatisticsConstants.casesTotalTitle
        totalCasesViewTitle.font = FontConstants.smallText
        
    }
    
    private func settingTotalCasesView() {
        totalCasesView.translatesAutoresizingMaskIntoConstraints = false
        totalCasesView.text = "6 600 836" // test change
        totalCasesView.font = FontConstants.totalCases
    }
    
    private func settingRecoveredViews() {
        recoveredViewTitle.translatesAutoresizingMaskIntoConstraints = false
        recoveredViewTitle.text = StatisticsConstants.recoveredTitle
        recoveredViewTitle.font = FontConstants.smallText
        recoveredViewTitle.textColor = ColorsConstants.recovered
        
        recoveredView.font = FontConstants.detailsCases
        recoveredView.text = "5 884 316" // test
        
        setupStackView(stackView: recoveredStackView, axis: .vertical, spacing: 2.0, arrangedSubviews: [recoveredViewTitle, recoveredView], alignment: .leading)
    }
    
    private func settingCriticalViews() {
        criticalViewTitle.translatesAutoresizingMaskIntoConstraints = false
        criticalViewTitle.text = StatisticsConstants.criticalTitle
        criticalViewTitle.font = FontConstants.smallText
        criticalViewTitle.textColor = ColorsConstants.critical
        
        criticalView.font = FontConstants.detailsCases
        criticalView.text = "546 021" // test
        
        setupStackView(stackView: criticalStackView, axis: .vertical, spacing: 2.0, arrangedSubviews: [criticalViewTitle, criticalView], alignment: .leading)
    }
    
    private func settingDeathsViews() {
        deathsViewTitle.translatesAutoresizingMaskIntoConstraints = false
        deathsViewTitle.text = StatisticsConstants.deathsTitle
        deathsViewTitle.font = FontConstants.smallText
        deathsViewTitle.textColor = ColorsConstants.deaths
        
        deathsView.font = FontConstants.detailsCases
        deathsView.text = "170 499" // test
        
        setupStackView(stackView: deathsStackView, axis: .vertical, spacing: 2.0, arrangedSubviews: [deathsViewTitle, deathsView], alignment: .leading)
    }
    
    private func addCasesDetailsStackView() {
        setupStackView(stackView: recoveredStackView, axis: .vertical, spacing: 2.0, arrangedSubviews: [recoveredViewTitle, recoveredView], alignment: .leading)

        setupStackView(stackView: self.casesDetailsStackView,
                            axis: .horizontal,
                            spacing: 5.0,
                            arrangedSubviews: [recoveredStackView, criticalStackView, deathsStackView], alignment: .center)
        
        contentStackView.addArrangedSubview(casesDetailsStackView)
    }
    
    // MARK: - Helpers
    
    private func setupStackView(stackView: UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat, arrangedSubviews: [UIView], alignment: UIStackView.Alignment) {
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        for subview in arrangedSubviews {
            stackView.addArrangedSubview(subview)
        }
    }
}
