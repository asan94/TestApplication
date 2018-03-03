//
//  ProductsManager.swift
//  TestApplication
//
//  Created by MacBook on 03.03.2018.
//  Copyright © 2018 AsanAmetov. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class ProductsManager: NSObject {
    static let sharedManager = ProductsManager()
    static let defaultRealm = DefaultRealm()
    var skuProducts: [SkuProduct]?
    static private func DefaultRealm() -> Realm {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("testApplication.realm")
        return try! Realm(configuration: config)
    }
    static func clearRealm() {
        let realmURL = self.defaultRealm.configuration.fileURL!
        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("note"),
            realmURL.appendingPathExtension("management")
        ]
        for URL in realmURLs {
            do {
                try FileManager.default.removeItem(at: URL)
            } catch {
                // handle error
            }
        }
    }
    func setTransactionToDB() {
        if let path = Bundle.main.path(forResource: "transactions", ofType: "plist") {
            if let array = NSArray(contentsOfFile: path) as? [[String: Any]] {
                let transactions: [Transactions] = Mapper<Transactions>(context: nil).mapArray(JSONArray: array)
                try! ProductsManager.defaultRealm.write {
                    ProductsManager.defaultRealm.add(transactions, update: false)
                }
                
                let skuProducts:[SkuProduct] = Mapper<SkuProduct>(context: nil).mapArray(JSONArray: array)
                try! ProductsManager.defaultRealm.write {
                    ProductsManager.defaultRealm.add(skuProducts, update: true)
                }
            }
            if let json = NSDictionary(contentsOfFile: path) as? [String: Any] {
                let transaction: Transactions = Mapper<Transactions>(context: nil).map(JSON: json)!
                try! ProductsManager.defaultRealm.write {
                    ProductsManager.defaultRealm.add(transaction, update: false)
                }
                let skuProduct:SkuProduct = Mapper<SkuProduct>(context: nil).map(JSON: json)!
                try! ProductsManager.defaultRealm.write {
                    ProductsManager.defaultRealm.add(skuProduct, update: true)
                }
            }
        }
    }
    func getRates() -> [Rate]? {
        if let path = Bundle.main.path(forResource: "rates", ofType: "plist") {
            if let array = NSArray(contentsOfFile: path) as? [[String: Any]] {
                let rates: [Rate] = Mapper<Rate>(context: nil).mapArray(JSONArray: array)
                    return rates
                }
            if let json = NSDictionary(contentsOfFile: path) as? [String: Any] {
                return [Mapper<Rate>(context: nil).map(JSON: json)!]
            }
        }
 
        return nil
    }
}
