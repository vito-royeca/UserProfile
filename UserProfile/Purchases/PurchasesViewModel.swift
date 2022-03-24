//
//  PurchasesViewModel.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/15/22.
//

import CoreData

class PurchasesViewModel : BaseViewModel {
    private(set) var purchases: [UPPurchase]! {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    override func handle<T: NSManagedObject>(result: Result<[T], Error>) {
        switch result {
        case .success(let data):
            if let purchases = data as? [UPPurchase] {
                self.purchases = purchases
            } else {

            }
        case .failure(let error):
            sendErrorToController(error)
        }
    }
}
