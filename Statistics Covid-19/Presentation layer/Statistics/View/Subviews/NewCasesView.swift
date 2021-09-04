//
//  NewCasesView.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 14.08.2021.
//

import UIKit

protocol INewCasesView: UIView {
    func fillNewCasesData(updateDate: Date?, confirmedToday: Int, confirmedYesterday: Int, dataFormatter: IDataFormatterService)
}

class NewCasesView: UIView {

    // MARK: - UI

    private let contentStackView = UIStackView()
    private let casesTodayViewTitle = UILabel()
    private let casesTodayView = UILabel()
    private let casesYesterdayView = UILabel()
    
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
        addContentStackView()
        settingCasesTodayViewTitle()
        settingCasesTodayView()
        settingCasesYesterdayView()
    }

    private func addContentStackView() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical
        contentStackView.spacing = 10.0
        contentStackView.alignment = .fill
        
        contentStackView.addArrangedSubview(casesTodayViewTitle)
        contentStackView.addArrangedSubview(casesTodayView)
        contentStackView.addArrangedSubview(casesYesterdayView)
        
        self.addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func settingCasesTodayViewTitle() {
        casesTodayViewTitle.translatesAutoresizingMaskIntoConstraints = false
        casesTodayViewTitle.text = StatisticsConstants.casesTodayTitle
        casesTodayViewTitle.font = FontConstants.smallText
        
    }
    
    private func settingCasesTodayView() {
        casesTodayView.translatesAutoresizingMaskIntoConstraints = false
        casesTodayView.font = FontConstants.casesToday
        casesTodayView.textColor = ColorsConstants.casesToday
    }
    
    private func settingCasesYesterdayView() {
        casesYesterdayView.translatesAutoresizingMaskIntoConstraints = false
        casesYesterdayView.text = "\(StatisticsConstants.defaultCasesValue) \(StatisticsConstants.casesYesterdayTitle)"
        casesYesterdayView.font = FontConstants.casesYesterday
        casesYesterdayView.textColor = ColorsConstants.casesYesterday
    }
}

// MARK: - INewCasesView

extension NewCasesView: INewCasesView {
    func fillNewCasesData(updateDate: Date?, confirmedToday: Int, confirmedYesterday: Int, dataFormatter: IDataFormatterService) {
        let today = dataFormatter.decimalFormatting(number: confirmedToday)
        let yesterday = dataFormatter.decimalFormatting(number: confirmedYesterday)
        
        casesTodayView.text = "+ \(today)"
        casesYesterdayView.text = "+ \(yesterday) \(StatisticsConstants.casesYesterdayTitle)"

        guard let date = updateDate else { return }
        let formattedDate = dataFormatter.getStringDate(format: "dd.MM.YYYY", date: date)
        casesTodayViewTitle.text = "\(StatisticsConstants.casesTodayTitle) \(formattedDate)"
    }
}
