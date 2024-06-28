//
//  ButtonStateModel.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 30.7.22..
//

import Foundation
import UIKit

struct ButtonStateModel {
    let title: LabelStateModel?
    let backgroundColor: UIColor?
    let cornerRadius: CGFloat?
    let isEnabled: Bool
    let isHidden: Bool?
    let image: UIImage?
    let textAlignment: NSTextAlignment?
    let borderColor: CGColor?
    let borderWidth: CGFloat?
    
    init(title: LabelStateModel? = nil,
         backgroundColor: UIColor? = nil,
         cornerRadius: CGFloat? = nil,
         isEnabled: Bool,
         isHidden: Bool? = nil,
         image: UIImage? = nil,
         textAlignment: NSTextAlignment? = nil,
         borderColor: CGColor? = nil,
         borderWidth: CGFloat? = nil) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.isEnabled = isEnabled
        self.isHidden = isHidden
        self.image = image
        self.textAlignment = textAlignment
        self.borderColor = borderColor
        self.borderWidth = borderWidth
    }
}
