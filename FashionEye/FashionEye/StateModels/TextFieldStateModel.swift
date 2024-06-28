//
//  TextFieldStateModel.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 30.7.22..
//

import Foundation
import UIKit

struct TextFieldStateModel {
    let text: String?
    let textColor: UIColor?
    let textFont: UIFont?
    let keyboardType: UIKeyboardType?
    let attributedPlaceholder:  NSAttributedString?
    var rightView: ButtonStateModel?
    var isHidden: Bool?
    let autocapitalizationType: UITextAutocapitalizationType?
    let textAlignment: NSTextAlignment?
    
    init(text: String? = nil,
         textColor: UIColor? = nil,
         textFont: UIFont? = nil,
         keyboardType: UIKeyboardType? = nil,
         attributedPlaceholder:  NSAttributedString? = nil,
         rightView: ButtonStateModel? = nil,
         isHidden: Bool? = nil,
         autocapitalizationType: UITextAutocapitalizationType? = nil,
         textAlignment: NSTextAlignment? = nil) {
        self.text = text
        self.textColor = textColor
        self.textFont = textFont
        self.keyboardType = keyboardType
        self.attributedPlaceholder = attributedPlaceholder
        self.rightView = rightView
        self.isHidden = isHidden
        self.autocapitalizationType = autocapitalizationType
        self.textAlignment = textAlignment
    }
}
