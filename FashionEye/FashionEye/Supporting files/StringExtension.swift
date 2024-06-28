//
//  StringExtension.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 26.8.22..
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
