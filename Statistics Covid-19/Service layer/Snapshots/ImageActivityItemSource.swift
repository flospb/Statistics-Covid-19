//
//  ImageActivityItemSource.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 29.08.2021.
//

import UIKit
import LinkPresentation

class ImageActivityItemSource: NSObject, UIActivityItemSource {
    let image: UIImage

    // MARK: - Initialization

    init(image: UIImage) {
        self.image = image
    }

    // MARK: - UIActivityItemSource

    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return image
    }

    func activityViewController(_ activityViewController: UIActivityViewController,
                                itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return image
    }

    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let imageProvider = NSItemProvider(object: image)
        let metadata = LPLinkMetadata()
        metadata.imageProvider = imageProvider
        metadata.title = StatisticsConstants.statisticsTitle
        return metadata
    }
}
