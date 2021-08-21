//
//  TestViewController.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 21.08.2021.
//

import UIKit

class TestViewController: UIViewController {

    var delegate: IStatisticsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .blue
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.codeCurrentCountry = "UA"
        dismiss(animated: true, completion: nil)
    }
}
