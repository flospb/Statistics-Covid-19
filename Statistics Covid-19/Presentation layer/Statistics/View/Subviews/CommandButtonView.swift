//
//  CommandButtonView.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 15.08.2021.
//

import UIKit

class CommandButtonView: UIButton {

    // MARK: - Setting view

    func settingView(title: String, titleColor: UIColor, backgroundColor: UIColor, imageName: String) {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 5

        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)

        let symbolConfiguration = UIImage.SymbolConfiguration(scale: .medium)
        guard let image = UIImage(systemName: imageName, withConfiguration: symbolConfiguration) else { return }

        let imageWithColor = image.withTintColor(titleColor, renderingMode: .alwaysOriginal)
        self.setImage(imageWithColor, for: .normal)

        self.imageView?.contentMode = .scaleAspectFit
        self.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 20)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
