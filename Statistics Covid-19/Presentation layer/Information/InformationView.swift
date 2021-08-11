//
//  InformationView.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 08.08.2021.
//

import UIKit

protocol IInformationView {
    var delegate: IInformationViewController? { get set }
    func setDelegateCollectionView()
}

class InformationView: UIView {
    var delegate: IInformationViewController?
        
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let contentViewTitle = UILabel()
    
    private let symptomsTitleView = UILabel()
    private let symptomsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let recommendationsTitleView = UILabel()
    private let recommendationsContainer = UIStackView()
    
    private let symptomsArray = SymptomsArray().symptomsArray
    
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
        
        addSymptomsTitleView()
        addSymptomsCollectionView()
        
        addRecommendationsTitleView()
        addRecommendationsContainer()
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
            contentView.heightAnchor.constraint(equalTo: self.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    private func addContentViewTitle() {
        contentViewTitle.text = InformationConstants.informationTitle
        contentViewTitle.font = TextFontConstants.bigBoldTitle
        contentViewTitle.translatesAutoresizingMaskIntoConstraints = false
        
        contentViewTitle.backgroundColor = .systemGray // test
        
        contentView.addSubview(contentViewTitle)
        
        NSLayoutConstraint.activate([
            contentViewTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentViewTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentViewTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func addSymptomsTitleView() {
        symptomsTitleView.text = InformationConstants.symptomsTitle
        symptomsTitleView.font = TextFontConstants.boldTitle
        symptomsTitleView.translatesAutoresizingMaskIntoConstraints = false
        
        symptomsTitleView.backgroundColor = .systemGray // test
        
        contentView.addSubview(symptomsTitleView)
        
        NSLayoutConstraint.activate([
            symptomsTitleView.topAnchor.constraint(equalTo: contentViewTitle.bottomAnchor, constant: 20),
            symptomsTitleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            symptomsTitleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func addSymptomsCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        
        symptomsCollectionView.collectionViewLayout = layout
        symptomsCollectionView.backgroundColor = .white
        symptomsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(symptomsCollectionView)
        
        NSLayoutConstraint.activate([
            symptomsCollectionView.topAnchor.constraint(equalTo: symptomsTitleView.bottomAnchor, constant: 20),
            symptomsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            symptomsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            symptomsCollectionView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func addRecommendationsTitleView() {
        recommendationsTitleView.text = InformationConstants.recommendations
        recommendationsTitleView.font = TextFontConstants.boldTitle
        recommendationsTitleView.translatesAutoresizingMaskIntoConstraints = false
        
        recommendationsTitleView.backgroundColor = .systemGray // test
        
        contentView.addSubview(recommendationsTitleView)
        
        NSLayoutConstraint.activate([
            recommendationsTitleView.topAnchor.constraint(equalTo: symptomsCollectionView.bottomAnchor, constant: 20),
            recommendationsTitleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recommendationsTitleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func addRecommendationsContainer() {
        recommendationsContainer.translatesAutoresizingMaskIntoConstraints = false
        recommendationsContainer.axis = .vertical
        recommendationsContainer.spacing = 15.0
        recommendationsContainer.backgroundColor = .systemOrange
        recommendationsContainer.alignment = .fill
        recommendationsContainer.distribution = .fillEqually
        
        for item in symptomsArray {
                  
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.spacing = 11.0
            stackView.alignment = .fill
            stackView.backgroundColor = .systemGray
            stackView.distribution = .fillEqually
            
            let recommendationTitle = UILabel()
            recommendationTitle.font = TextFontConstants.boldTitle
            recommendationTitle.numberOfLines = 0
            recommendationTitle.text = item.title
            
            let recommendationContent = UILabel()
            recommendationContent.font = TextFontConstants.boldTitle
            recommendationContent.numberOfLines = 0
            recommendationContent.text = item.content
            
            stackView.addArrangedSubview(recommendationTitle)
            stackView.addArrangedSubview(recommendationContent)
            
            recommendationsContainer.addArrangedSubview(stackView)
        }

        contentView.addSubview(recommendationsContainer)
        
        NSLayoutConstraint.activate([
            recommendationsContainer.topAnchor.constraint(equalTo: recommendationsTitleView.bottomAnchor, constant: 20),
            recommendationsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recommendationsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
}

// MARK: - IInformationView

extension InformationView: IInformationView {
    func setDelegateCollectionView() {
        guard let controller = delegate else { return }
        symptomsCollectionView.delegate = controller
        symptomsCollectionView.dataSource = controller
        symptomsCollectionView.register(InformationCollectionViewCell.self,
                                        forCellWithReuseIdentifier: CellNames.informationCollectionCell)
    }
}
