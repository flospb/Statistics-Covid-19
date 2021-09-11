//
//  CountryListTableViewCell.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 21.08.2021.
//

import UIKit

class CountryListTableViewCell: UITableViewCell {

    // MARK: - UI

    private let containerView = UIStackView()
    private let countryNameView = UILabel()
    private let selectedCountryImageView = UIImageView()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        settingView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setting view

    private func settingView() {
        addContainerView()
        settingCountryNameView()
        settingSelectedCountryImageView()
    }

    private func addContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.axis = .horizontal
        containerView.spacing = 5.0
        containerView.alignment = .fill

        containerView.addArrangedSubview(countryNameView)
        containerView.addArrangedSubview(selectedCountryImageView)

        self.addSubview(self.containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }

    private func settingCountryNameView() {
        countryNameView.font = FontConstants.mediumText
        countryNameView.numberOfLines = 0
    }

    private func settingSelectedCountryImageView() {
        selectedCountryImageView.translatesAutoresizingMaskIntoConstraints = false
        selectedCountryImageView.contentMode = .scaleAspectFit
        selectedCountryImageView.clipsToBounds = true

        NSLayoutConstraint.activate([
            selectedCountryImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    func configureCell(countryName: String, selected: Bool) {
        countryNameView.text = countryName
        selectedCountryImageView.image = selected ? UIImage(systemName: CountryListConstants.selectedCountryImage) : nil
    }
}
