//
//  UPUser+CoreDataProperties.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/14/22.
//
//

import Foundation
import CoreData


extension UPUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UPUser> {
        return NSFetchRequest<UPUser>(entityName: "UPUser")
    }

    @NSManaged public var name: String?
    @NSManaged public var userName: String?
    @NSManaged public var fullName: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var registration: Date?
    @NSManaged public var image: String?
    @NSManaged public var lastUpdate: Date?
    @NSManaged public var purchases: NSSet?

}

// MARK: Generated accessors for purchases
extension UPUser {

    @objc(addPurchasesObject:)
    @NSManaged public func addToPurchases(_ value: UPPurchase)

    @objc(removePurchasesObject:)
    @NSManaged public func removeFromPurchases(_ value: UPPurchase)

    @objc(addPurchases:)
    @NSManaged public func addToPurchases(_ values: NSSet)

    @objc(removePurchases:)
    @NSManaged public func removeFromPurchases(_ values: NSSet)

}

extension UPUser : Identifiable {

}
