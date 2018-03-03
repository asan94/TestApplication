//
//  ProductsListViewController.swift
//  TestApplication
//
//  Created by MacBook on 03.03.2018.
//  Copyright © 2018 AsanAmetov. All rights reserved.
//

import UIKit

class ProductsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel = ProductsListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getSkuProducts()
        self.tableViewSettings()
        self.setupBindings()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    fileprivate func tableViewSettings() {
        self.tableView.registerCellNib(ProductCell.self)
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        self.tableView.setFooter()
        self.tableView?.estimatedRowHeight = 88
        let label = UILabel(frame: self.view.frame)
        label.text = "Products not found. Check files with products"
        label.backgroundColor = .lightGray
        label.numberOfLines = 4
        label.textAlignment = .center
        self.tableView.backgroundView = label
    }
    fileprivate func setupBindings() {
        //bind news to table view
        self.viewModel.products.bind(to: self.tableView!) { dataSource, indexPath, tableView in
            tableView.backgroundView = nil
            let cell = tableView.dequeueReusableCell(withIdentifier: String.className(ProductCell.self)) as! ProductCell
            let product = dataSource[indexPath.row]
            cell.setupWithSkuProduct(product)
            return cell
        }.dispose(in: self.reactive.bag)
        self.tableView.selectedRow.observeNext(with: { [weak self] (row) in
            let product = self?.viewModel.getProductByIndex(row)
            let transactionVC = TransactionViewController()
            transactionVC.viewModel.skuProduct = product!
            self?.navigationController?.pushViewController(transactionVC, animated: true)
        }).dispose(in: self.reactive.bag)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
