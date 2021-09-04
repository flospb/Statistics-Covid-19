//
//  RecommendationView.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 11.08.2021.
//

import UIKit

class RecommendationView: UIView {

    // MARK: - UI

    private let mainContentStackView = UIStackView()
    private let rightContentStackView = UIStackView()

    private let imageView = UIImageView()
    private let titleView = UILabel()
    private let descriptionView = UILabel()

    // MARK: - Initialization

    init(frame: CGRect, title: String, content: String, imageName: String) {
        super.init(frame: frame)
        settingView(title: title, content: content, imageName: imageName)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setting view

    private func settingView(title: String, content: String, imageName: String) {
        addMainContentStackView()
        addImageView(imageName: imageName)
        addRightContentStackView(title: title, content: content)
    }

    private func addMainContentStackView() {
        mainContentStackView.translatesAutoresizingMaskIntoConstraints = false
        mainContentStackView.axis = .horizontal
        mainContentStackView.spacing = 10.0
        mainContentStackView.backgroundColor = .systemGray6
        mainContentStackView.alignment = .fill
        mainContentStackView.layer.cornerRadius = 5

        self.addSubview(mainContentStackView)
        NSLayoutConstraint.activate([
            mainContentStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainContentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainContentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainContentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func addImageView(imageName: String) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleToFill

        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 30),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
    }

    private func addRightContentStackView(title: String, content: String) {
        titleView.font = FontConstants.mediumBoldTitle
        titleView.numberOfLines = 0
        titleView.text = title
        titleView.font = FontConstants.smallBoldTitle

        descriptionView.font = FontConstants.smallText
        descriptionView.numberOfLines = 0
        descriptionView.text = content
        descriptionView.textColor = ColorsConstants.recommendationDescription

        rightContentStackView.translatesAutoresizingMaskIntoConstraints = false
        rightContentStackView.axis = .vertical
        rightContentStackView.spacing = 5.0
        rightContentStackView.alignment = .fill

        rightContentStackView.addArrangedSubview(titleView)
        rightContentStackView.addArrangedSubview(descriptionView)

        self.addSubview(rightContentStackView)
        NSLayoutConstraint.activate([
            rightContentStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            rightContentStackView.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 10),
            rightContentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            rightContentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}
