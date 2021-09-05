//
//  PhoneContactView.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 05.09.2021.
//

import UIKit

class PhoneContactView: UIView {

    // MARK: - UI

    private let contentStackView = UIStackView()

    private let titleView = UILabel()
    private let descriptionView = UILabel()

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
        settingTitleView()
        settingDescriptionView()
    }

    private func addContentStackView() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical
        contentStackView.spacing = 5.0
        contentStackView.alignment = .fill
        contentStackView.layer.cornerRadius = 5

        contentStackView.addArrangedSubview(titleView)
        contentStackView.addArrangedSubview(descriptionView)

        self.addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }

    private func settingTitleView() {
        titleView.font = FontConstants.smallBoldText
        titleView.text = PhoneContactModel.phoneContactTitle
        titleView.textColor = .systemBlue
    }

    private func settingDescriptionView() {
        descriptionView.font = FontConstants.mediumBoldTitle
        descriptionView.text = PhoneContactModel.phoneContact
    }
}
