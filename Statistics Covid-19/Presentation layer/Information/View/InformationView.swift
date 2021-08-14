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
    
    private let symptomsViewTitle = UILabel()
    private let symptomsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let symptomsArray = SymptomsArray().symptomsArray
    
    private let recommendationsViewTitle = UILabel()
    private let recommendationsContainer = UIStackView()

    private let anchorСonstant = CGFloat(20)
    
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
        self.backgroundColor = .yellow // test
        
        addScrollView()
        addContentView()
        addContentViewTitle()
        
        addSymptomsViewTitle()
        addSymptomsCollectionView()
        
        addRecommendationsViewTitle()
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
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .systemBlue // test
        
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        let heightAnchor = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightAnchor.priority = UILayoutPriority(rawValue: 250)
        heightAnchor.isActive = true
    }
    
    private func addContentViewTitle() {
        contentViewTitle.translatesAutoresizingMaskIntoConstraints = false
        contentViewTitle.text = InformationConstants.informationTitle
        contentViewTitle.font = TextFontConstants.bigBoldTitle
        contentViewTitle.backgroundColor = .systemGray // test
        
        contentView.addSubview(contentViewTitle)
        
        NSLayoutConstraint.activate([
            contentViewTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: anchorСonstant),
            contentViewTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: anchorСonstant),
            contentViewTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -anchorСonstant)
        ])
    }
    
    private func addSymptomsViewTitle() {
        symptomsViewTitle.translatesAutoresizingMaskIntoConstraints = false
        symptomsViewTitle.text = InformationConstants.symptomsTitle
        symptomsViewTitle.font = TextFontConstants.boldTitle
        symptomsViewTitle.backgroundColor = .systemGray // test
        
        contentView.addSubview(symptomsViewTitle)
        
        NSLayoutConstraint.activate([
            symptomsViewTitle.topAnchor.constraint(equalTo: contentViewTitle.bottomAnchor, constant: anchorСonstant),
            symptomsViewTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: anchorСonstant),
            symptomsViewTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -anchorСonstant)
        ])
    }
    
    private func addSymptomsCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        
        symptomsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        symptomsCollectionView.collectionViewLayout = layout
        symptomsCollectionView.backgroundColor = .white

        contentView.addSubview(symptomsCollectionView)
        
        NSLayoutConstraint.activate([
            symptomsCollectionView.topAnchor.constraint(equalTo: symptomsViewTitle.bottomAnchor, constant: anchorСonstant),
            symptomsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: anchorСonstant),
            symptomsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -anchorСonstant),
            symptomsCollectionView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func addRecommendationsViewTitle() {
        recommendationsViewTitle.translatesAutoresizingMaskIntoConstraints = false
        recommendationsViewTitle.text = InformationConstants.recommendations
        recommendationsViewTitle.font = TextFontConstants.boldTitle
        recommendationsViewTitle.backgroundColor = .systemGray // test
        
        contentView.addSubview(recommendationsViewTitle)
        
        NSLayoutConstraint.activate([
            recommendationsViewTitle.topAnchor.constraint(equalTo: symptomsCollectionView.bottomAnchor, constant: anchorСonstant),
            recommendationsViewTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: anchorСonstant),
            recommendationsViewTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -anchorСonstant)
        ])
    }
    
    private func addRecommendationsContainer() {
        recommendationsContainer.translatesAutoresizingMaskIntoConstraints = false
        recommendationsContainer.axis = .vertical
        recommendationsContainer.spacing = 10.0
        recommendationsContainer.alignment = .fill
        
        for item in symptomsArray {
            let recommendationView = RecommendationView(frame: .zero, title: item.title, content: item.content, imageName: "")
            recommendationsContainer.addArrangedSubview(recommendationView)
        }
        
        contentView.addSubview(recommendationsContainer)
        
        NSLayoutConstraint.activate([
            recommendationsContainer.topAnchor.constraint(equalTo: recommendationsViewTitle.bottomAnchor, constant: anchorСonstant),
            recommendationsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: anchorСonstant),
            recommendationsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -anchorСonstant),
            recommendationsContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -anchorСonstant)
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
