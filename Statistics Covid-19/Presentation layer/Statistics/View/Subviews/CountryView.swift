//
//  CountryView.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 14.08.2021.
//

import UIKit

protocol ICountryView: UIView {
    func fillCountryData(country: String, image: UIImage?)
}

class CountryView: UIView {

    // MARK: - UI

    private let contentStackView = UIStackView()
    private let countryImage = UIImageView()
    private let countryName = UILabel()
    private let listOpeningImage = UIImageView()

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
        layer.cornerRadius = 15

        addContentStackView()
        settingCountryImage()
        settingCountryName()
        settingListOpeningImage()
    }

    private func addContentStackView() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .horizontal
        contentStackView.spacing = anchorСonstant
        contentStackView.alignment = .fill

        contentStackView.addArrangedSubview(countryImage)
        contentStackView.addArrangedSubview(countryName)
        contentStackView.addArrangedSubview(listOpeningImage)

        self.addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: anchorСonstant),
            contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -anchorСonstant),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func settingCountryImage() {
        countryImage.translatesAutoresizingMaskIntoConstraints = false
        countryImage.layer.borderWidth = 1.5
        countryImage.layer.borderColor = UIColor.systemGray6.cgColor
        countryImage.layer.cornerRadius = 20.0
        countryImage.layer.masksToBounds = true
        countryImage.contentMode = .scaleAspectFill
        countryImage.clipsToBounds = true

        NSLayoutConstraint.activate([
            countryImage.heightAnchor.constraint(equalToConstant: 40),
            countryImage.widthAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func settingCountryName() {
        countryName.text = StatisticsConstants.emptyCountryName
        countryName.font = FontConstants.mediumBoldTitle
        countryName.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        countryName.accessibilityValue = StatisticsConstants.countryAccessibilityValue
    }

    private func settingListOpeningImage() {
        listOpeningImage.translatesAutoresizingMaskIntoConstraints = false
        listOpeningImage.image = UIImage(systemName: StatisticsConstants.listOpeningImage)
        listOpeningImage.contentMode = .scaleAspectFit
    }
}

// MARK: - ICountryView

extension CountryView: ICountryView {
    func fillCountryData(country: String, image: UIImage?) {
        countryName.text = country
        countryImage.image = image
    }
}
