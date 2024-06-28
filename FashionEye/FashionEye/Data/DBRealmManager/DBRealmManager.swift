//
//  DBRealmManager.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 26.8.22..
//

import Foundation
import RealmSwift

class DBRealmManager {
    private init() {}
    static let shared = DBRealmManager()
    let realm = try! Realm()
    
    func saveApparel(_ apparel: Apparel) {
        let dbApparel = apparel.mapToDBApparel()
        
        realm.beginWrite()
        realm.add(dbApparel)
        try! realm.commitWrite()
    }
    
    func fetchApparel() -> [Apparel] {
        let apparel = realm.objects(DBApparel.self)
        return apparel.map { $0.mapToApparel() }
    }
}

class DBApparel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var typeClass: String = ""
    @objc dynamic var purchasePath: String = ""
    @objc dynamic var imagePath: String = ""
    @objc dynamic var store: String = ""
    @objc dynamic var color: String = ""
}

extension DBApparel {
    func mapToApparel() -> Apparel {
        return Apparel(id: self.id,
                       typeClass: self.typeClass,
                       purchasePath: self.purchasePath,
                       imagePath: self.imagePath,
                       store: self.store,
                       color: self.color)
    }
}
