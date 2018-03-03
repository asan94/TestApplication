//
//  Rate.swift
//  TestApplication
//
//  Created by MacBook on 03.03.2018.
//  Copyright © 2018 AsanAmetov. All rights reserved.
//

import ObjectMapper

class Rate: Mappable {
    var from: String!
    var rate: String!
    var to: String!

    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        self.rate <- map["rate"]
        self.from <- map["from"]
        self.to <- map["to"]

    }
}
