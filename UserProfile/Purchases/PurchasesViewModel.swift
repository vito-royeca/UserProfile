//
//  PurchasesViewModel.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/15/22.
//

import CoreData

struct TransactionSection {
    var totalAmount: Double
    var transactions: [UPPurchase]
}

class PurchasesViewModel : BaseViewModel {
    private(set) var purchases: [[String: TransactionSection]]! {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    override func handle<T: NSManagedObject>(result: Result<[T], Error>) {
        switch result {
        case .success(let data):
            if let purchases = data as? [UPPurchase] {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM yyyy"
                
                self.purchases = [[String: TransactionSection]]()
                
                var currentPurchases = [[String: TransactionSection]]()
                
                for purchase in purchases {
                    if let transactiontionDate = purchase.transactionDate {
                        let dateString = formatter.string(from: transactiontionDate)
                        let transactionAmount = purchase.transactionAmount
                        
                        
                        var currentPurchase: [String: TransactionSection]?
                        for item in currentPurchases {
                            for (k,_) in item {
                                if k == dateString {
                                    currentPurchase = item
                                    break
                                }
                            }
                        }
                        
                        if currentPurchase != nil {
                            var transaction = currentPurchase?[currentPurchase?.keys.first ?? ""]
                            transaction?.transactions.append(purchase)
                            transaction?.totalAmount += transactionAmount
                        
                        } else {
                            var array = [UPPurchase]()
                            array.append(purchase)
                            
                            let currentPurchase = TransactionSection(totalAmount: transactionAmount, transactions: array)
                            
                            currentPurchases.append([dateString: currentPurchase])
                        }
                    }
                }
                self.purchases = currentPurchases
                
                
            } else {
                sendErrorToController(UPError.dataNotFound)
            }
        case .failure(let error):
            sendErrorToController(error)
        }
    }
}
