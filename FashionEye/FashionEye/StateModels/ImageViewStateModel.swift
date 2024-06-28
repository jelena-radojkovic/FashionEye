//
//  ImageViewStateModel.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 30.7.22..
//

import Foundation
import UIKit

struct ImageViewStateModel {
    let image: UIImage?
    let contentMode: UIImageView.ContentMode?
    let sizeToFit: Bool
    let cornerRadius: CGFloat?
    let masksToBounds: Bool?
    let clipsToBounds: Bool?
    let isHidden: Bool?
    
    init(image: UIImage? = nil,
         contentMode: UIImageView.ContentMode? = nil,
         sizeToFit: Bool = true,
         cornerRadius: CGFloat? = nil,
         masksToBounds: Bool? = nil,
         clipsToBounds: Bool? = nil,
         isHidden: Bool? = nil) {
        self.image = image
        self.contentMode = contentMode
        self.sizeToFit = sizeToFit
        self.cornerRadius = cornerRadius
        self.masksToBounds = masksToBounds
        self.clipsToBounds = clipsToBounds
        self.isHidden = isHidden
    }
}
