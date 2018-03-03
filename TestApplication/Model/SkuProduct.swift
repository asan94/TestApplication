//
//  SkuProducts.swift
//  TestApplication
//
//  Created by MacBook on 03.03.2018.
//  Copyright © 2018 AsanAmetov. All rights reserved.
//

import RealmSwift
import ObjectMapper_Realm
import ObjectMapper

class SkuProduct: Object, Mappable {
    @objc dynamic var sku: String!
    var transactions: [Transactions]?

    override static func primaryKey() -> String? {
        return "sku"
    }
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        self.sku <- map["sku"]
    }
}
