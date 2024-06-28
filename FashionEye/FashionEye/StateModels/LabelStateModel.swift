//
//  LabelStateModel.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 30.7.22..
//

import Foundation
import UIKit

struct LabelStateModel {
    let text: String?
    let attributedText: NSAttributedString?
    let textColor: UIColor?
    let font: UIFont?
    let numberOfLines: Int?
    let isHidden: Bool?
    let backgroundColor: UIColor?
    let textAlignment: NSTextAlignment?
    let cornerRadius: CGFloat?
    let masksToBounds: Bool?
    
    init(text: String? = nil,
         attributedText: NSAttributedString? = nil,
         textColor: UIColor? = nil,
         font: UIFont? = nil,
         numberOfLines: Int? = nil,
         isHidden: Bool? = nil,
         backgroundColor: UIColor? = nil,
         textAlignment: NSTextAlignment? = nil,
         cornerRadius: CGFloat? = nil,
         masksToBounds: Bool? = nil) {
        self.text = text
        self.attributedText = attributedText
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines
        self.isHidden = isHidden
        self.backgroundColor = backgroundColor
        self.textAlignment = textAlignment
        self.cornerRadius = cornerRadius
        self.masksToBounds = masksToBounds
    }
}
