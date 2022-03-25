//
//  PurchasesDataSource.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/15/22.
//

import Foundation
import UIKit

class PurchasesTableViewDataSource<CELL: UITableViewCell, T> : NSObject, UITableViewDataSource {
    
    private var cellIdentifier : String!
    private var items : [[String: TransactionSection]]!
    var configureCell : (CELL, T) -> () = {_,_ in }
    
    
    init(cellIdentifier : String, items : [[String: TransactionSection]], configureCell : @escaping (CELL, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let purchaseSection = items[section]
        
        for (_,v) in purchaseSection {
            return v.transactions.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        let purchaseSection = items[indexPath.section]
        
        for (_,v) in purchaseSection {
            let item = v.transactions[indexPath.row]
            self.configureCell(cell, item as! T)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let purchaseSection = items[section]
        
        for (k,_) in purchaseSection {
            return k
        }
        
        return nil
    }
}
