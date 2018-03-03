//
//  TableView.swift
//  TestApplication
//
//  Created by MacBook on 03.03.2018.
//  Copyright © 2018 AsanAmetov. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit
public extension UITableView {
    
    func registerCellClass(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        self.register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    func registerCellNib(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func setFooter() {
        self.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 0))
        
    }
}
extension UITableView {
    var selectedRow: Signal<Int, NoError> {
        return reactive.delegate.signal(for: #selector(UITableViewDelegate.tableView(_:didSelectRowAt:))) { (subject: SafePublishSubject<Int>, _: UITableView, indexPath: IndexPath) in
            subject.next(indexPath.row)
        }
    }
}
