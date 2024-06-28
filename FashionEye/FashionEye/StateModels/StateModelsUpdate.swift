//
//  StateModelsUpdate.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 30.7.22..
//

import Foundation
import UIKit

// MARK: Utils for updating UIView objects with state models.
extension UILabel {
    func update(with stateModel: LabelStateModel) {
        self.text = stateModel.text ?? self.text
        self.textColor = stateModel.textColor ?? self.textColor
        self.font = stateModel.font ?? self.font
        self.textAlignment = stateModel.textAlignment ?? self.textAlignment
        self.attributedText = stateModel.attributedText ?? self.attributedText
        self.layer.cornerRadius = stateModel.cornerRadius ?? self.layer.cornerRadius
        self.layer.masksToBounds = stateModel.masksToBounds ?? self.layer.masksToBounds
        updateSharedProperties(stateModel)
    }
    
    func roundTopCorners() {
        self.layer.cornerRadius = 16
        self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.clipsToBounds = true
    }
    
    // Utils for updating label with empty model if attributed text has multiple fonts and/or colors.
    // Although said so in UILabel documentation, text color and font
    // aren't ignored if attributedText already set.
    
    func updateAttributedLabelWithMultipleFonts(_ stateModel: LabelStateModel) {
        self.textColor = stateModel.textColor ?? self.textColor
        self.attributedText = stateModel.attributedText ?? self.attributedText
        updateSharedProperties(stateModel)
    }
    
    func updateAttributedLabelWithMultipleForegroundColors(_ stateModel: LabelStateModel) {
        self.font = stateModel.font ?? self.font
        self.attributedText = stateModel.attributedText ?? self.attributedText
        updateSharedProperties(stateModel)
    }
    
    func updateAttributedLabelWithMultipleFontsAndForegroundColors(_ stateModel: LabelStateModel) {
        self.attributedText = stateModel.attributedText ?? self.attributedText
        updateSharedProperties(stateModel)
    }
    
    private func updateSharedProperties(_ stateModel: LabelStateModel) {
        self.numberOfLines = stateModel.numberOfLines ?? self.numberOfLines
        self.backgroundColor = stateModel.backgroundColor ?? self.backgroundColor
        self.isHidden = stateModel.isHidden ?? self.isHidden
    }
}

extension UIButton {
    func update(with stateModel: ButtonStateModel) {
        self.setTitle(stateModel.title?.text ?? self.currentTitle, for: .normal)
        self.setTitle(stateModel.title?.text ?? self.currentTitle, for: .disabled)
        self.setTitleColor(stateModel.title?.textColor ?? self.currentTitleColor, for: .normal)
        self.setTitleColor(stateModel.title?.textColor ?? self.currentTitleColor, for: .disabled)
        self.titleLabel?.font  = stateModel.title?.font ?? self.titleLabel?.font
        self.isEnabled = stateModel.isEnabled
        self.backgroundColor = stateModel.backgroundColor ?? self.backgroundColor
        self.layer.cornerRadius = stateModel.cornerRadius ?? self.layer.cornerRadius
        self.isHidden = stateModel.isHidden ?? self.isHidden
        self.setImage(stateModel.image?.withRenderingMode(.alwaysOriginal) ?? self.image(for: .normal), for: .normal)
        self.setImage(stateModel.image?.withRenderingMode(.alwaysOriginal) ?? self.image(for: .disabled), for: .disabled)
        self.imageView?.contentMode = .scaleAspectFit
        self.titleLabel?.textAlignment = stateModel.textAlignment ?? self.titleLabel?.textAlignment ?? .center
        self.layer.borderColor = stateModel.borderColor ?? self.layer.borderColor
        self.layer.borderWidth = stateModel.borderWidth ?? self.layer.borderWidth
    }
}

extension UITextField {
    func update(with stateModel: TextFieldStateModel) {
        self.text = stateModel.text ?? self.text
        self.font = stateModel.textFont ?? self.font
        self.textColor = stateModel.textColor ?? self.textColor
        self.attributedPlaceholder = stateModel.attributedPlaceholder ?? self.attributedPlaceholder
        self.keyboardType = stateModel.keyboardType ?? self.keyboardType
        if let rightButton = self.rightView as? UIButton,
           let updateModel = stateModel.rightView {
            rightButton.update(with: updateModel)
            self.rightViewMode = (updateModel.isHidden ?? true) ? .never : .always
            self.rightView?.frame = self.rightViewRect(forBounds: self.bounds)
        }
        self.isHidden = stateModel.isHidden ?? self.isHidden
        self.autocapitalizationType = stateModel.autocapitalizationType ?? self.autocapitalizationType
        self.textAlignment = stateModel.textAlignment ?? self.textAlignment
    }
}

extension UIImageView {
    func update(with stateModel: ImageViewStateModel) {
        self.image = stateModel.image ?? self.image
        if stateModel.sizeToFit { self.sizeToFit() }
        self.contentMode = stateModel.contentMode ?? self.contentMode
        self.layer.cornerRadius = stateModel.cornerRadius ?? self.layer.cornerRadius
        self.layer.masksToBounds = stateModel.masksToBounds ?? self.layer.masksToBounds
        self.clipsToBounds = stateModel.clipsToBounds ?? self.clipsToBounds
        self.isHidden = stateModel.isHidden ?? self.isHidden
    }
}

extension UIView {
    func addBottomGrayBorder(width: CGFloat? = nil, at height: CGFloat = 43) {
        let bottomLine = CALayer()
        if let width = width {
            bottomLine.frame = CGRect(x: 0.0, y: height,
                                      width: width,
                                      height: 1.0)
        } else {
            let width = UIScreen.main.bounds.size.width - (DefaultAnchors.leading * 2 * ResizingManager.ScreenResizeCoefficient.getCoefficient().width)
            bottomLine.frame = CGRect(x: 0.0, y: height,
                                      width: width,
                                      height: 1.0)
            
        }
        self.layer.addSublayer(bottomLine)
    }
    
    func addTopGrayBorder(width: CGFloat) {
        let topLine = CALayer()
        topLine.frame = CGRect(x: 0.0, y: 0.0,
                                  width: width * ResizingManager.ScreenResizeCoefficient.getCoefficient().width,
                                  height: 1.0)
        self.layer.addSublayer(topLine)
    }
}
