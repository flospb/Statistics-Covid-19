//
//  VaccinationControllerMocks.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 14.09.2021.
//

import Foundation
import UIKit

class VaccinationViewMock: IVaccinationView {
    var delegate: IVaccinationViewController?

    var setImageWasCalled = false
    func setImage(image: UIImage) {
        setImageWasCalled = true
    }
}
