//
//  InformationViewController.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 08.08.2021.
//

import UIKit

protocol IInformationViewController {
}

class InformationViewController: UIViewController {
    private var router: IMainRouter
    private var informationView: IInformationView
    
    // MARK: - Initialization
    
    init(router: IMainRouter, view: IInformationView) {
        self.router = router
        self.informationView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = informationView as? UIView
        informationView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        informationView.symptomsCollectionView.delegate = self
        informationView.symptomsCollectionView.dataSource = self
        informationView.symptomsCollectionView.register(InformationCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}

extension InformationViewController: IInformationViewController {}
extension InformationViewController: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource

extension InformationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5 // test
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? InformationCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .lightGray // test
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension InformationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: CGFloat(146), height: CGFloat(180))
        return size
    }
}
