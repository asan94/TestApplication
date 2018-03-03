//
//  ProductCell.swift
//  TestApplication
//
//  Created by MacBook on 03.03.2018.
//  Copyright © 2018 AsanAmetov. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    @IBOutlet weak var skuLabel: UILabel!
    
    @IBOutlet weak var transactionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupWithSkuProduct(_ skuProduct: SkuProduct) {
        self.skuLabel.text = skuProduct.sku
        self.transactionLabel.text = "\(skuProduct.transactions!.count) transactions"
    }
    func setupWithTransactions(_ transaction: Transactions) {
        self.skuLabel.text = Float(transaction.amount)!.getAmountWithCurrency(currency: transaction.currency)
        self.transactionLabel.text = transaction.gbpAmount.getAmountWithCurrency(currency: "GBP")        
    }
}
