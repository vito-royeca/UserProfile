//
//  UPPurchase+CoreDataProperties.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/14/22.
//
//

import Foundation
import CoreData


extension UPPurchase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UPPurchase> {
        return NSFetchRequest<UPPurchase>(entityName: "UPPurchase")
    }

    @NSManaged public var image: String?
    @NSManaged public var itemName: String?
    @NSManaged public var transactionDate: Date?
    @NSManaged public var transactionAmount: Double
    @NSManaged public var serial: String?
    @NSManaged public var productDescription: String?
    @NSManaged public var lastUpdate: Date?
    @NSManaged public var user: UPUser?

}

extension UPPurchase : Identifiable {

}
