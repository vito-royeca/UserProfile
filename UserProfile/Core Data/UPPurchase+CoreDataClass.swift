//
//  UPPurchase+CoreDataClass.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/14/22.
//
//

import Foundation
import CoreData

@objc(UPPurchase)
public class UPPurchase: NSManagedObject {

}

// MARK: - Formats
extension UPPurchase {
    var priceFormatted: String {
        return String.format(usd: transactionAmount)
    }
    
    var purchaseDateFormatted: String? {
        guard let purchaseDate = transactionDate else {
            return nil
        }
        
        return String.format(date: purchaseDate, with: Constants.normalDate)
    }
}
