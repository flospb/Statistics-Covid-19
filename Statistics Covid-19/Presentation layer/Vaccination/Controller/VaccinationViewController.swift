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
}

class VaccinationViewController: UIViewController {

    // MARK: - Dependencies

    private var vaccinationView: IVaccinationView
    private var router: IMainRouter

    // MARK: - Initialization

    init(router: IMainRouter, view: IVaccinationView) {
        self.router = router
        self.vaccinationView = view
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

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
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
        print(link)
        // TODO
        guard let url = URL(string: link) else { return }
        UIApplication.shared.open(url)
    }
}

extension VaccinationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            vaccinationView.setSelectedImage(image: selectedImage)

        }
        self.dismiss(animated: true, completion: nil)
    }
}
