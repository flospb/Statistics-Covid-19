//
//  ImageStorageServiceMocks.swift
//  Statistics Covid-19Tests
//
//  Created by Сергей Флоря on 14.09.2021.
//

import Foundation
import UIKit

class ImageStorageServiceMock: IImageStorageService {
    var clearImageWasCalled = false
    func clearImage(imageName: String) {
        clearImageWasCalled = true
    }

    func saveImage(imageName: String, image: UIImage, completion: @escaping (ResultWorkingWithImage?) -> Void) {}
    func loadImage(imageName: String, completion: @escaping (UIImage?) -> Void) {}
}
