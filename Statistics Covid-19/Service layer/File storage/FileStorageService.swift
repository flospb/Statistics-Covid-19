//
//  FileStorageService.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 06.09.2021.
//

import UIKit

protocol IImageStorageService {
    func saveImage(imageName: String, image: UIImage, completion: @escaping (ResultWorkingWithImage?) -> Void)
    func loadImage(imageName: String, completion: @escaping (UIImage?) -> Void)
    func clearImage(imageName: String)
}

class ImageStorageService: IImageStorageService {

    // MARK: - Models

    let queue = DispatchQueue.global(qos: .utility)

    // MARK: - Public

    func saveImage(imageName: String, image: UIImage, completion: @escaping (ResultWorkingWithImage?) -> Void) {
        queue.async {
            guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

            let fileUrl = documentsDirectory.appendingPathComponent(imageName)
            guard let data = image.jpegData(compressionQuality: 1) else { return }

            do {
                try data.write(to: fileUrl)
            } catch {
                completion(.saveError)
            }
        }
    }

    func loadImage(imageName: String, completion: @escaping (UIImage?) -> Void) {
        queue.async {
            guard let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
                return
            }
            let imageUrl = URL(fileURLWithPath: documentsDirectory).appendingPathComponent(imageName)
            if let image = UIImage(contentsOfFile: imageUrl.path) {
                completion(image)
            }
        }
    }

    func clearImage(imageName: String) {
        queue.async {
            guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            let fileUrl = documentsDirectory.appendingPathComponent(imageName)
            if FileManager.default.fileExists(atPath: fileUrl.path) {
                try? FileManager.default.removeItem(atPath: fileUrl.path)
            }
        }
    }
}

// MARK: - Errors

enum ResultWorkingWithImage: Error {
    case saveError

    var message: String {
        switch self {
        case .saveError:
            return "Ошибка сохранения изображения"
        }
    }
}
