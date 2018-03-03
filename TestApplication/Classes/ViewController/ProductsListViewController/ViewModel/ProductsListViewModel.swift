//
//  ProductsListViewModel.swift
//  TestApplication
//
//  Created by MacBook on 03.03.2018.
//  Copyright © 2018 AsanAmetov. All rights reserved.
//

import ReactiveKit
import Bond

class ProductsListViewModel {
    var products = MutableObservableArray<SkuProduct>()
    init() {
        ProductsManager.clearRealm()
        ProductsManager.sharedManager.setTransactionToDB()
    }
    func getSkuProducts() {
       let skuProducts =  Array(ProductsManager.defaultRealm.objects(SkuProduct.self))
        skuProducts.forEach { (skuProduct) in
            skuProduct.transactions = self.getTransactionsBySku(skuProduct.sku)
        }
        products.replace(with: skuProducts)
    }
    func getTransactionsBySku(_ sku: String) -> [Transactions] {
        let predicate = NSPredicate(format: "sku contains[c] %@", sku)
        let trancations = Array(ProductsManager.defaultRealm.objects(Transactions.self).filter(predicate))
        return trancations
    }
    func getProductByIndex(_ index: Int) -> SkuProduct {
        return products.array[index]
    }
}
