//
//  TotalCasesView.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 15.08.2021.
//

import UIKit

protocol ITotalCasesView: UIView {
    func fillTotalCasesData(total: Int, recovered: Int, critical: Int, deaths: Int, dataFormatter: DataFormatter)
}

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
    
    private let defaultCasesValue = StatisticsConstants.defaultCasesValue

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

        let subviews = [totalCasesViewTitle, totalCasesView, casesDetailsStackView]
        configureStackView(stackView: contentStackView, axis: .vertical, spacing: 10.0, subviews: subviews, alignment: .fill)
        
        self.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func addCasesDetailsStackView() {
        let subviews = [recoveredStackView, criticalStackView, deathsStackView]
        configureStackView(stackView: casesDetailsStackView, axis: .horizontal, spacing: 5.0, subviews: subviews, alignment: .center)
        casesDetailsStackView.distribution = .fillEqually
        
        contentStackView.addArrangedSubview(casesDetailsStackView)
    }
    
    private func settingCasesTodayViewTitle() {
        totalCasesViewTitle.translatesAutoresizingMaskIntoConstraints = false
        totalCasesViewTitle.text = StatisticsConstants.casesTotalTitle
        totalCasesViewTitle.font = FontConstants.smallText
    }
    
    private func settingTotalCasesView() {
        totalCasesView.translatesAutoresizingMaskIntoConstraints = false
        totalCasesView.text = defaultCasesValue
        totalCasesView.font = FontConstants.totalCases
    }
    
    private func settingRecoveredViews() {
        recoveredViewTitle.translatesAutoresizingMaskIntoConstraints = false
        recoveredViewTitle.text = StatisticsConstants.recoveredTitle
        recoveredViewTitle.font = FontConstants.smallText
        recoveredViewTitle.textColor = ColorsConstants.recovered
        
        recoveredView.font = FontConstants.detailsCases
        recoveredView.text = defaultCasesValue
        
        let subviews = [recoveredViewTitle, recoveredView]
        configureStackView(stackView: recoveredStackView, axis: .vertical, spacing: 2.0, subviews: subviews, alignment: .center)
    }
    
    private func settingCriticalViews() {
        criticalViewTitle.translatesAutoresizingMaskIntoConstraints = false
        criticalViewTitle.text = StatisticsConstants.criticalTitle
        criticalViewTitle.font = FontConstants.smallText
        criticalViewTitle.textColor = ColorsConstants.critical
        
        criticalView.font = FontConstants.detailsCases
        criticalView.text = defaultCasesValue
        
        let subviews = [criticalViewTitle, criticalView]
        configureStackView(stackView: criticalStackView, axis: .vertical, spacing: 2.0, subviews: subviews, alignment: .center)
    }
    
    private func settingDeathsViews() {
        deathsViewTitle.translatesAutoresizingMaskIntoConstraints = false
        deathsViewTitle.text = StatisticsConstants.deathsTitle
        deathsViewTitle.font = FontConstants.smallText
        deathsViewTitle.textColor = ColorsConstants.deaths
        
        deathsView.font = FontConstants.detailsCases
        deathsView.text = defaultCasesValue
        
        let subviews = [deathsViewTitle, deathsView]
        configureStackView(stackView: deathsStackView, axis: .vertical, spacing: 2.0, subviews: subviews, alignment: .center)
    }
    
    // MARK: - Helpers
    
    private func configureStackView(stackView: UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat, subviews: [UIView], alignment: UIStackView.Alignment) {
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        
        for subview in subviews {
            stackView.addArrangedSubview(subview)
        }
    }
}

// MARK: - ITotalCasesView

extension TotalCasesView: ITotalCasesView {
    func fillTotalCasesData(total: Int, recovered: Int, critical: Int, deaths: Int, dataFormatter: DataFormatter) {
        totalCasesView.text = dataFormatter.decimalFormatting(number: total)
        recoveredView.text = dataFormatter.decimalFormatting(number: recovered)
        criticalView.text = dataFormatter.decimalFormatting(number: critical)
        deathsView.text = dataFormatter.decimalFormatting(number: deaths)
    }
}
