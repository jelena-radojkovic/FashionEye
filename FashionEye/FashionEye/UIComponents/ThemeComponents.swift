//
//  ThemeComponents.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 14.8.22..
//

import Foundation
import UIKit


enum ThemeComponents {
    static func enabledButton(title: String) -> ButtonStateModel {
        return ButtonStateModel(title: LabelStateModel(text: title,
                                                       textColor: .white,
                                                       font: .m16),
                                backgroundColor: .secondaryBranchColor,
                                cornerRadius: 16,
                                isEnabled: true)
    }
    
    static func customEnabledButton(title: String, color: UIColor) -> ButtonStateModel {
        return ButtonStateModel(title: LabelStateModel(text: title,
                                                       textColor: .white,
                                                       font: .m16),
                                backgroundColor: color,
                                cornerRadius: 16,
                                isEnabled: true)
    }
    
    static func customDisabledButton(title: String, color: UIColor) -> ButtonStateModel {
        return ButtonStateModel(title: LabelStateModel(text: title,
                                                       textColor: .white,
                                                       font: .m16),
                                backgroundColor: color,
                                cornerRadius: 16,
                                isEnabled: false)
    }
    
    static func disabledButton(title: String) -> ButtonStateModel {
        return ButtonStateModel(title: LabelStateModel(text: title,
                                                       textColor: .tertiaryTextColor,
                                                       font: .m16),
                                backgroundColor: .secondaryLightColor,
                                cornerRadius: 16,
                                isEnabled: false)
    }
    
    static func enabledEmptyButton(title: String) -> ButtonStateModel {
        return ButtonStateModel(title: LabelStateModel(text: title,
                                                       textColor: .primaryTextColor,
                                                       font: .m16),
                                backgroundColor: .white,
                                cornerRadius: 16,
                                isEnabled: true,
                                borderColor: UIColor.primaryTextColor.cgColor,
                                borderWidth: 2)
    }
    
    static func disabledEmptyButton(title: String) -> ButtonStateModel {
        return ButtonStateModel(title: LabelStateModel(text: title,
                                                       textColor: .tertiaryTextColor,
                                                       font: .m16),
                                backgroundColor: .tertiaryTextColor,
                                cornerRadius: 16,
                                isEnabled: false)
    }
}
