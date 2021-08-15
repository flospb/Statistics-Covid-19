//
//  CountryView.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 14.08.2021.
//

import UIKit

class CountryView: UIView {
    private let contentStackView = UIStackView()
    
    private let countryImage = UIImageView()
    private let countryName = UILabel()
    private let listOpeningImage = UIImageView()
    
    // MARK: - Initialization
    
    init(frame: CGRect, country: CountryModel) {
        super.init(frame: frame)
        settingView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting view
    
    private func settingView() {
        addContentStackView()
        
        settingCountryImage()
        settingCountryName()
        settingListOpeningImage()
    }
    
    private func addContentStackView() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .horizontal
        contentStackView.spacing = 10.0
        contentStackView.alignment = .fill
    
        contentStackView.addArrangedSubview(countryImage)
        contentStackView.addArrangedSubview(countryName)
        contentStackView.addArrangedSubview(listOpeningImage)
        
        self.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func settingCountryImage() {
        countryImage.translatesAutoresizingMaskIntoConstraints = false
        countryImage.image = UIImage(systemName: "flag.fill")
        countryImage.layer.borderWidth = 1 // TODO change
        // TODO border color
        countryImage.layer.cornerRadius = 15.0
        countryImage.layer.masksToBounds = true
        countryImage.contentMode = .scaleToFill
        
        NSLayoutConstraint.activate([
            countryImage.heightAnchor.constraint(equalToConstant: 30),
            countryImage.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func settingCountryName() {
        countryName.text = "Россия" // test
        countryName.font = FontConstants.mediumBoldTitle
    }
    
    private func settingListOpeningImage() {
        listOpeningImage.translatesAutoresizingMaskIntoConstraints = false
        listOpeningImage.image = UIImage(systemName: "arrowtriangle.down.fill")
        listOpeningImage.contentMode = .scaleAspectFit
    }
}
