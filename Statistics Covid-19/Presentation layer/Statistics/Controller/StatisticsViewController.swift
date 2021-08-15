//
//  StatisticsViewController.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 08.08.2021.
//

import UIKit

protocol IStatisticsViewController {
    func countryTapped()
    func shareButtonTapped()
    func refreshButtonTapped()
}

class StatisticsViewController: UIViewController {
    private var router: IMainRouter
    private var statisticsView: IStatisticsView
    
    // MARK: - Initialization
    
    init(router: IMainRouter, view: IStatisticsView) {
        self.router = router
        self.statisticsView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = statisticsView as? UIView
        statisticsView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // test
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        // router.openTestVC()
    }
}

// MARK: - IStatisticsViewController

extension StatisticsViewController: IStatisticsViewController {
    func countryTapped() {
        print("Country tapped")
    }
    
    func shareButtonTapped() {
        print("Share tapped")
    }
    
    func refreshButtonTapped() {
        print("Refresh tapped")
    }
}
