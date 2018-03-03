//
//  Transactions.swift
//  TestApplication
//
//  Created by MacBook on 03.03.2018.
//  Copyright © 2018 AsanAmetov. All rights reserved.
//

import RealmSwift
import ObjectMapper_Realm
import ObjectMapper

class Transactions: Object, Mappable {
    @objc dynamic var sku: String!
    @objc dynamic var amount: String!
    @objc dynamic var currency: String!
    var gbpAmount: Float = 0
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        self.sku <- map["sku"]
        self.amount <- map["amount"]
        self.currency <- map["currency"]
        
    }
}
