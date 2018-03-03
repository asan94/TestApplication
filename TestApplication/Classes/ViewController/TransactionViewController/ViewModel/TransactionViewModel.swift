//
//  TransactionViewModel.swift
//  TestApplication
//
//  Created by MacBook on 03.03.2018.
//  Copyright © 2018 AsanAmetov. All rights reserved.
//

import ReactiveKit
import Bond
class TransactionViewModel {
    var skuProduct: SkuProduct?
    var rates: [Rate]?
    var ratesFailure = PublishSubject<NSError, NoError>()
    var transactions = MutableObservableArray<Transactions>()
    var totalAmount = Observable<Float>(0)
    convenience init(skuProduct: SkuProduct) {
        self.init(skuProduct: skuProduct)
        self.skuProduct = skuProduct
    }
    func getTitle() -> String{
        return "Transactions for \(self.skuProduct!.sku!)"
    }
    func getTransactions() {
        self.rates = ProductsManager.sharedManager.getRates()
        if self.rates == nil {
            self.ratesFailure.next(self.getError(message: "Rates not found"))
            return
        }
        self.setGbpAmount()
    }
    
    func setGbpAmount() {
        let transactions = self.skuProduct!.transactions!
        var rate: Rate?
        var totalAmount: Float = 0
        transactions.forEach { (transaction) in
            if transaction.currency == "GBP" {
                transaction.gbpAmount = Float(transaction.amount)!
            }else {
                let constain = self.rates!.contains(where: { (rate) -> Bool in
                    rate.from == transaction.currency && rate.to == "GBP"
                })
                if constain {
                    let rates = self.rates!.filter({ (rate) -> Bool in
                        rate.from == transaction.currency && rate.to == "GBP"
                    })
                    rate = rates.first
                    transaction.gbpAmount = Float(transaction.amount)! * Float(rate!.rate)!
                } else {
                    let findRates = self.rates!.filter{ $0.from == transaction.currency }
                    let tmpRate = findRates.first
                    var amount = Float(transaction.amount)!
                    if findRates.count > 0 {
                        amount = amount * Float(tmpRate!.rate)!
                        let rates = self.rates!.filter({ (rate) -> Bool in
                            rate.from == tmpRate!.to && rate.to == "GBP"
                        })
                        if rates.count > 0 {
                            rate = rates.first
                        }
                    }
                    if rate != nil {
                        transaction.gbpAmount = amount * Float(rate!.rate)!
                    } else {
                        transaction.gbpAmount = 0
                    }
                }
            }
            totalAmount += transaction.gbpAmount
        }
        self.totalAmount.value = totalAmount
        self.transactions.replace(with: transactions)
    }

    func getError(message: String) -> NSError {
        let userInfo: [AnyHashable : Any] = [NSLocalizedDescriptionKey :  NSLocalizedString("Error", value: message, comment: "")]
        let error = NSError(domain: "ShiploopHttpResponseErrorDomain", code: 10, userInfo: userInfo as? [String : Any])
        return error
    }
}
