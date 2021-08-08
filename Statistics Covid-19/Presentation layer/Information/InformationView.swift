//
//  InformationView.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 08.08.2021.
//

import UIKit

protocol IInformationView {
    var delegate: IInformationViewController? { get set }
    var symptomsCollectionView: UICollectionView { get set } // test
}

class InformationView: UIView {
    var delegate: IInformationViewController?
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let contentViewTitle = UILabel()
    
    private let symptomsTitleView = UILabel()
    var symptomsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let symptomsContainer = UIStackView()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews
    
    private func setupView() {
        self.backgroundColor = .yellow // test
        
        addScrollView()
        addContentView()
        addContentViewTitle()
        
        addSymptomsContainer()
    }
    
    private func addScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
    }
    
    private func addContentView() {
        contentView.backgroundColor = .systemBlue
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])
    }
    
    private func addContentViewTitle() {
        contentViewTitle.text = InformationConstants.informationTitle
        contentViewTitle.font = TextFontConstants.bigBoldTitle
        
        contentViewTitle.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(contentViewTitle)
        
        NSLayoutConstraint.activate([
            contentViewTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentViewTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentViewTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20)
        ])
    }
    
    private func addSymptomsContainer() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        
        symptomsCollectionView.collectionViewLayout = layout
        symptomsCollectionView.backgroundColor = .white
        symptomsCollectionView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(symptomsCollectionView)
        
        NSLayoutConstraint.activate([
            symptomsCollectionView.topAnchor.constraint(equalTo: contentViewTitle.bottomAnchor, constant: 20),
            symptomsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            symptomsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            symptomsCollectionView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
}

extension InformationView: IInformationView {}
