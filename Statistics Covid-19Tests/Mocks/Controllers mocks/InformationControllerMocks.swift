//
//  InformationControllerMocks.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 13.09.2021.
//

import Foundation
import UIKit

class InformationViewMock: IInformationView {
    var delegate: IInformationViewController?

    var setDelegateCollectionViewWasCalled = false
    func setDelegateCollectionView() {
        setDelegateCollectionViewWasCalled = true
    }
}
