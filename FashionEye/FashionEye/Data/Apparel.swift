//
//  Apparel.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 22.8.22..
//

import Foundation

struct Apparel: Decodable {
    let id: Int
    let typeClass: String
    let purchasePath: String
    let imagePath: String
    let store: String
    let color: String
}

extension Apparel {
    func mapToDBApparel() -> DBApparel {
        let dbApparel = DBApparel()
        dbApparel.id = self.id
        dbApparel.purchasePath = self.purchasePath
        dbApparel.imagePath = self.imagePath
        dbApparel.typeClass = self.typeClass
        dbApparel.store = self.store
        dbApparel.color = self.color
        return dbApparel
    }
}

typealias Clothing = [Apparel]
