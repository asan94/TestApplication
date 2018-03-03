//
//  TransactionViewController.swift
//  TestApplication
//
//  Created by MacBook on 03.03.2018.
//  Copyright © 2018 AsanAmetov. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var viewModel = TransactionViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.viewModel.getTitle()
        self.tableViewSettings()
        self.setupBindings()
        self.viewModel.getTransactions()

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
        self.tableView.delegate = self
    }
    fileprivate func setupBindings() {
        self.viewModel.transactions.bind(to: self.tableView!) { dataSource, indexPath, tableView in
            let cell = tableView.dequeueReusableCell(withIdentifier: String.className(ProductCell.self)) as! ProductCell
            cell.accessoryType = .none
            let transaction = dataSource[indexPath.row]
            cell.setupWithTransactions(transaction)
            return cell
            }.dispose(in: self.reactive.bag)
        self.viewModel.ratesFailure.observeNext{ [weak self] (error) in
            self?.showWithError(error: error)
        }.dispose(in: self.reactive.bag)
        
        self.viewModel.totalAmount.observeNext { [weak self] (amount) in
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 21))
            label.text = "Total: \(amount.getAmountWithCurrency(currency: "GBP"))"
            label.backgroundColor = .lightGray
            self?.tableView.tableHeaderView = label
        }.dispose(in: self.reactive.bag)
    
    }

    func showWithError(error: NSError) {
        let errorMessage: String = error.localizedDescription

        let alertVC = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel) { action in
            self.navigationController?.popViewController(animated: true)
        })
        self.present(alertVC, animated: true, completion: nil)
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
