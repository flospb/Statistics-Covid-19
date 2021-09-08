//
//  VaccinationView.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 04.09.2021.
//

import UIKit

protocol IVaccinationView {
    var delegate: IVaccinationViewController? { get set }
    func setImage(image: UIImage)
}

class VaccinationView: UIView {

    // MARK: - Dependencies

    var delegate: IVaccinationViewController?

    // MARK: - UI

    private let vaccinationViewTitle = UILabel()
    private let qrCertificateCode = UIImageView()
    private let choiceCertificateTitle = UILabel()
    private let clearCertificateButton = UIButton(type: .system)
    private let contactsViewTitle = UILabel()
    private let phoneContactView = PhoneContactView()
    private let linkContactView = LinkContactView()

    // MARK: - Models

    private let anchorСonstant: CGFloat = 20
    private let doubleAnchorСonstant: CGFloat = 40

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

        addVaccinationViewTitle()
        addQrCertificateCode()
        addChoiceCertificateTitle()
        addClearCertificateButton()
        addContactsViewTitle()
        addPhoneContactView()
        addLinkContactView()
    }

    private func addVaccinationViewTitle() {
        vaccinationViewTitle.translatesAutoresizingMaskIntoConstraints = false
        vaccinationViewTitle.text = VaccinationConstants.vaccinationTitle
        vaccinationViewTitle.font = FontConstants.largeBoldTitle

        self.addSubview(vaccinationViewTitle)
        NSLayoutConstraint.activate([
            vaccinationViewTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: anchorСonstant),
            vaccinationViewTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: anchorСonstant),
            vaccinationViewTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -anchorСonstant)
        ])
    }

    private func addQrCertificateCode() {
        qrCertificateCode.translatesAutoresizingMaskIntoConstraints = false
        qrCertificateCode.backgroundColor = UIColor.systemGray6
        qrCertificateCode.isUserInteractionEnabled = true

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(qrCertificateCodeTapped(tapGestureRecognizer:)))
        qrCertificateCode.addGestureRecognizer(tapGestureRecognizer)

        self.addSubview(qrCertificateCode)
        NSLayoutConstraint.activate([
            qrCertificateCode.topAnchor.constraint(equalTo: self.vaccinationViewTitle.bottomAnchor, constant: anchorСonstant),
            qrCertificateCode.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            qrCertificateCode.widthAnchor.constraint(equalToConstant: 240),
            qrCertificateCode.heightAnchor.constraint(equalToConstant: 240)
        ])
    }

    private func addChoiceCertificateTitle() {
        choiceCertificateTitle.translatesAutoresizingMaskIntoConstraints = false
        choiceCertificateTitle.text = VaccinationConstants.choiceCertificateTitle
        choiceCertificateTitle.font = FontConstants.smallBoldTitle
        choiceCertificateTitle.textColor = .systemGray
        choiceCertificateTitle.textAlignment = .center
        choiceCertificateTitle.numberOfLines = 0

        self.addSubview(choiceCertificateTitle)
        NSLayoutConstraint.activate([
            choiceCertificateTitle.centerYAnchor.constraint(equalTo: qrCertificateCode.centerYAnchor),
            choiceCertificateTitle.leadingAnchor.constraint(equalTo: qrCertificateCode.leadingAnchor, constant: anchorСonstant),
            choiceCertificateTitle.trailingAnchor.constraint(equalTo: qrCertificateCode.trailingAnchor, constant: -anchorСonstant)
        ])
    }

    private func addClearCertificateButton() {
        clearCertificateButton.translatesAutoresizingMaskIntoConstraints = false
        clearCertificateButton.isHidden = true
        clearCertificateButton.setTitle(VaccinationConstants.clearCertificateButton, for: .normal)

        clearCertificateButton.addTarget(self, action: #selector(clearCertificateButtonAction), for: .touchUpInside)

        self.addSubview(clearCertificateButton)
        NSLayoutConstraint.activate([
            clearCertificateButton.topAnchor.constraint(equalTo: qrCertificateCode.bottomAnchor, constant: anchorСonstant / 2),
            clearCertificateButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: anchorСonstant),
            clearCertificateButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -anchorСonstant)
        ])
    }

    private func addContactsViewTitle() {
        contactsViewTitle.translatesAutoresizingMaskIntoConstraints = false
        contactsViewTitle.text = VaccinationConstants.contactsTitle
        contactsViewTitle.font = FontConstants.mediumBoldTitle

        self.addSubview(contactsViewTitle)
        NSLayoutConstraint.activate([
            contactsViewTitle.topAnchor.constraint(equalTo: clearCertificateButton.bottomAnchor, constant: anchorСonstant / 2),
            contactsViewTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: anchorСonstant),
            contactsViewTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -anchorСonstant)
        ])
    }

    private func addPhoneContactView() {
        phoneContactView.translatesAutoresizingMaskIntoConstraints = false
        phoneContactView.backgroundColor = .systemGray6

        self.addSubview(phoneContactView)
        NSLayoutConstraint.activate([
            phoneContactView.topAnchor.constraint(equalTo: contactsViewTitle.bottomAnchor, constant: anchorСonstant),
            phoneContactView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: anchorСonstant),
            phoneContactView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -anchorСonstant)
        ])
    }

    private func addLinkContactView() {
        linkContactView.translatesAutoresizingMaskIntoConstraints = false
        linkContactView.backgroundColor = .systemGray6

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(linkContactTapped(tapGestureRecognizer:)))
        linkContactView.addGestureRecognizer(tapGestureRecognizer)

        self.addSubview(linkContactView)
        NSLayoutConstraint.activate([
            linkContactView.topAnchor.constraint(equalTo: phoneContactView.bottomAnchor, constant: anchorСonstant),
            linkContactView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: anchorСonstant),
            linkContactView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -anchorСonstant)
        ])
    }

    // MARK: - Actions

    @objc func qrCertificateCodeTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        animationTap(view: qrCertificateCode)
        delegate?.qrCertificateCodeTapped()
    }

    @objc func clearCertificateButtonAction() {
        delegate?.clearCertificateButtonTapped()
        qrCertificateCode.image = nil
        clearCertificateButton.isHidden = true
        choiceCertificateTitle.isHidden = false
    }

    @objc func linkContactTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        animationTap(view: linkContactView)
        delegate?.linkContactTapped(url: linkContactView.link)
    }

    // MARK: - Animations

    private func animationTap(view: UIView) {
        UIView.animate(withDuration: 0.1) {
            view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            view.backgroundColor = .systemGray3
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                view.transform = CGAffineTransform.identity
                view.backgroundColor = .systemGray6
            }
        }
    }
}

// MARK: - IVaccinationView

extension VaccinationView: IVaccinationView {
    func setImage(image: UIImage) {
        qrCertificateCode.image = image
        clearCertificateButton.isHidden = false
        choiceCertificateTitle.isHidden = true
    }
}
