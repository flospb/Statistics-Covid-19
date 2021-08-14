//
//  InformationViewController.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 08.08.2021.
//

import UIKit

protocol IInformationViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
}

class InformationViewController: UIViewController {
    private var router: IMainRouter
    private var informationView: IInformationView
    
    private var cellName = CellNames.informationCollectionCell
    private var symptomsCollection = SymptomModel().imageAddresses
    
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
        informationView.setDelegateCollectionView()
    }
}

// MARK: - ICollectionViewController

extension InformationViewController: IInformationViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        symptomsCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as? InformationCollectionViewCell else { return UICollectionViewCell() }
        let imageName = symptomsCollection[indexPath.row]
        cell.configureCell(imageName: imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension InformationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: CGFloat(140), height: CGFloat(180))
        return size
    }
}
