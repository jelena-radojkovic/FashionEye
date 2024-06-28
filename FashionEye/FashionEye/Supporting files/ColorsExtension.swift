//
//  ColorsExtension.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 14.8.22..
//

import Foundation
import UIKit

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

// HIFI Colors
extension UIColor {
    // text colors
    static let primaryTextColor = UIColor(rgb: 0x333333)
    static let secondaryTextColor = UIColor(rgb: 0x777777)
    static let tertiaryTextColor = UIColor(rgb: 0xBDBDBD)

    // brand colors
    static let primaryBrandColor = UIColor(rgb: 0x330080)
    static let secondaryBranchColor = UIColor(rgb: 0xff8080)
    static let tertiaryBrandColor = UIColor(rgb: 0x402B6B)
    
    // feedback colors
    static let primaryErrorColor = UIColor(rgb: 0xF04E3E)
    
    // secondary colors
    static let secondaryLightColor = UIColor(rgb: 0xF2F2F2)
    static let secondaryMediumColor = UIColor(rgb: 0xE4E4E4)
    static let secondaryDarkColor = UIColor(rgb: 0x333333)
}
