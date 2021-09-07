//
//  VaccinationViewController.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 04.09.2021.
//

import UIKit

protocol IVaccinationViewController {
    func qrCertificateCodeTapped()
    func linkContactTapped(link: String)
    func clearCertificateButtonTapped()
}

class VaccinationViewController: UIViewController {

    // MARK: - Dependencies

    private var vaccinationView: IVaccinationView
    private var router: IMainRouter
    private var imageStorageService: IImageStorageService

    // MARK: - Initialization

    init(view: IVaccinationView, router: IMainRouter, imageStorageService: IImageStorageService) {
        self.vaccinationView = view
        self.router = router
        self.imageStorageService = imageStorageService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        self.view = vaccinationView as? UIView
        vaccinationView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // MARK: - Private

    private func saveImage(image: UIImage) {
        imageStorageService.saveImage(imageName: VaccinationConstants.certificateName, image: image) { [weak self] saveResult in
            guard let self = self, let result = saveResult else { return }
            DispatchQueue.main.async {
                self.showAlert(for: result)
            }
        }
    }

    private func loadImage() {
        imageStorageService.loadImage(imageName: VaccinationConstants.certificateName) { [weak self] result in
            guard let self = self, let image = result else { return }
            DispatchQueue.main.async {
                self.vaccinationView.setImage(image: image)
            }
        }
    }

    private func showAlert(for error: ResultWorkingWithImage) {
        let alert = UIAlertController(title: AlertConstants.alertTitle, message: error.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AlertConstants.alertActionOk, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

// MARK: - IVaccinationViewController

extension VaccinationViewController: IVaccinationViewController {
    func qrCertificateCodeTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }

    func linkContactTapped(link: String) {
//        guard let url = URL(string: link) else { return }
//        UIApplication.shared.open(url)
        self.navigationController?.pushViewController(WebViewController(url: link), animated: true)
    }

    func clearCertificateButtonTapped() {
        imageStorageService.clearImage(imageName: VaccinationConstants.certificateName)
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension VaccinationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        vaccinationView.setImage(image: selectedImage)
        saveImage(image: selectedImage)
        self.dismiss(animated: true, completion: nil)
    }
}
