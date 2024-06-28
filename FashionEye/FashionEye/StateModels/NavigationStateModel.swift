//
//  NavigationStateModel.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 30.7.22..
//

import Foundation
import UIKit

struct NavigationItemStateModel {
    let text: String
    let image: UIImage
    
    init(text: String = "",
         image: UIImage? = nil) {
        self.text = text
        self.image = image ?? UIImage()
    }
    
    static var defaultBackItem: NavigationItemStateModel {
        NavigationItemStateModel(image: UIImage(named: "back"))
    }
}
