//
//  StatisticsView.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 14.08.2021.
//

import UIKit

protocol IStatisticsView {
    var delegate: IStatisticsViewController? { get set }
    func fillCountryData(countryStatistics: CountryStatisticsModel, dataFormatter: IDataFormatterService)
    func updateStatActivityIndicator(run: Bool)
}

class StatisticsView: UIView {

    // MARK: - Dependencies

    var delegate: IStatisticsViewController?

    // MARK: - UI

    private let statisticsViewTitle = UILabel()
    private let activityIndicatorView = UIActivityIndicatorView()
    private let countryView: ICountryView = CountryView()
    private let newCasesView: INewCasesView = NewCasesView()
    private let totalCasesView: ITotalCasesView = TotalCasesView()
    private let buttonsStackView = UIStackView()
    private let shareButtonView = CommandButtonView(type: .system) // todo
    private let refreshButtonView = CommandButtonView(type: .system) // todo

    // MARK: - Models

    private let anchorСonstant: CGFloat = 20
    private let doubleAnchorСonstant: CGFloat = 40 // todo
    
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
        addActivityIndicatorView()

        settingShareButtonView()
        settingRefreshButtonView()
    }

    private func addStatisticsViewTitle() {
        statisticsViewTitle.translatesAutoresizingMaskIntoConstraints = false
        statisticsViewTitle.text = StatisticsConstants.statisticsTitle
        statisticsViewTitle.font = FontConstants.largeBoldTitle
        
        self.addSubview(statisticsViewTitle)
        NSLayoutConstraint.activate([
            statisticsViewTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: anchorСonstant),
            statisticsViewTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: anchorСonstant),
            statisticsViewTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -anchorСonstant)
        ])
    }
    
    private func addCountryView() {
        countryView.translatesAutoresizingMaskIntoConstraints = false
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
    
        self.addSubview(newCasesView)
        NSLayoutConstraint.activate([
            newCasesView.topAnchor.constraint(equalTo: countryView.bottomAnchor, constant: anchorСonstant),
            newCasesView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: anchorСonstant),
            newCasesView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -anchorСonstant)
        ])
    }
    
    private func addTotalCasesView() {
        totalCasesView.translatesAutoresizingMaskIntoConstraints = false
    
        self.addSubview(totalCasesView)
        NSLayoutConstraint.activate([
            totalCasesView.topAnchor.constraint(equalTo: newCasesView.bottomAnchor, constant: doubleAnchorСonstant),
            totalCasesView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: anchorСonstant),
            totalCasesView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -anchorСonstant)
        ])
    }
    
    private func addButtonsStackView() {
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
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
    
    private func addActivityIndicatorView() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.hidesWhenStopped = true
        
        self.addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicatorView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: anchorСonstant * 2)
        ])
    }

    private func settingShareButtonView() {
        shareButtonView.addTarget(self, action: #selector(shareButtonViewAction(_:)), for: .touchUpInside)
        shareButtonView.settingView(title: StatisticsConstants.shareTitle,
                                    titleColor: UIColor.darkText,
                                    backgroundColor: ColorsConstants.shareBackground,
                                    imageName: StatisticsConstants.shareImageName)
    }
    
    private func settingRefreshButtonView() {
        refreshButtonView.addTarget(self, action: #selector(refreshButtonViewAction(_:)), for: .touchUpInside)
        refreshButtonView.settingView(title: StatisticsConstants.refreshTitle,
                                      titleColor: UIColor.white,
                                      backgroundColor: ColorsConstants.refreshBackground,
                                      imageName: StatisticsConstants.refreshImageName)
    }

    // MARK: - Actions
    
    @objc func countryTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.1, animations: startAnimation) {  _ in
            UIView.animate(withDuration: 0.1, animations: self.finalAnimation) { _ in
                self.delegate?.countryTapped()
            }
        }
    }
    
    @objc private func shareButtonViewAction(_ sender: UIButton) {
        let snapshot = self.snapshotView(afterScreenUpdates: false)
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
        snapshot?.drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()

        delegate?.shareButtonTapped(image: image)
    }
    
    @objc private func refreshButtonViewAction(_ sender: UIButton) {
        activityIndicatorView.startAnimating()
        delegate?.refreshButtonTapped()
    }
    
    // MARK: - Animations
    
    private func startAnimation() {
        countryView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        countryView.backgroundColor = .systemGray6
    }
    
    private func finalAnimation() {
        countryView.transform = CGAffineTransform.identity
        countryView.backgroundColor = .systemBackground
    }
}

// MARK: - IStatisticsView

extension StatisticsView: IStatisticsView {
    func fillCountryData(countryStatistics: CountryStatisticsModel, dataFormatter: IDataFormatterService) {
        countryView.fillCountryData(country: countryStatistics.country.name, image: countryStatistics.country.image)

        newCasesView.fillNewCasesData(updateDate: countryStatistics.updateDate,
                                      confirmedToday: countryStatistics.confirmedToday,
                                      confirmedYesterday: countryStatistics.confirmedYesterday,
                                      dataFormatter: dataFormatter)
        
        totalCasesView.fillTotalCasesData(total: countryStatistics.totalConfirmed,
                                          recovered: countryStatistics.totalRecovered,
                                          critical: countryStatistics.totalCritical,
                                          deaths: countryStatistics.totalDeaths,
                                          dataFormatter: dataFormatter)
    }

    func updateStatActivityIndicator(run: Bool) {
        if run {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
}
