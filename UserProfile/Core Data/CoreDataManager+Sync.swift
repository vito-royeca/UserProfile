//
//  CoreDataManager+Sync.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/23/22.
//

import CoreData

extension CoreDataManager {
    
    func syncToCoreData<T: Codable>(_ jsonData: T) {
        if let user = jsonData as? UserJSON {
            sync(user)
        } else if let purchases = jsonData as? [PurchaseJSON] {
            sync(purchases)
        } else if let refunds = jsonData as? [RefundJSON] {
            sync(refunds)
        }
    }
    
    func sync(_ user: UserJSON) {
        let context = persistentContainer.viewContext


        let _ = self.user(from: user, context: context, type: UPUser.self)

        saveContext()
    }
    
    func sync(_ purchases: [PurchaseJSON]) {
        let predicate = NSPredicate(format: "userName = %@", Constants.defaultUserName)

        guard let users = find(UPUser.self,
                               properties: nil,
                               predicate: predicate,
                               sortDescriptors: nil,
                               createIfNotFound: false),
              let user = users.first else {
            return
        }

        let context = persistentContainer.viewContext

        for purchase in purchases {
            if let newPurchase = self.purchase(from: purchase, context: context, type: UPPurchase.self) {
                newPurchase.user = user
            }
        }
        saveContext()
    }
    
    func sync(_ refunds: [RefundJSON]) {
        let predicate = NSPredicate(format: "userName = %@", Constants.defaultUserName)

        guard let users = find(UPUser.self,
                               properties: nil,
                               predicate: predicate,
                               sortDescriptors: nil,
                               createIfNotFound: false),
              let user = users.first else {
            return
        }

        let context = persistentContainer.viewContext

        for refund in refunds {
            if let newRefund = self.refund(from: refund, context: context, type: UPPurchase.self) {
                newRefund.user = user
            }
        }
        saveContext()
    }
    
    // MARK: - User
    func user<T: NSManagedObject>(from user: UserJSON, context: NSManagedObjectContext, type: T.Type) -> T? {
        var props = [String: Any]()
        
        props["name"] = user.name
        props["userName"] = user.userName
        props["fullName"] = user.fullName
        props["phoneNumber"] = user.phoneNumber
        props["registration"] = user.registration
        props["image"] = user.image
        props["lastUpdate"] = Date()
        
        let predicate = NSPredicate(format: "userName = %@", user.userName)
        
        return find(type,
                    properties: props,
                    predicate: predicate,
                    sortDescriptors: nil,
                    createIfNotFound: true)?.first
    }
    
    // MARK: - Purchase
    func purchase<T: NSManagedObject>(from purchase: PurchaseJSON, context: NSManagedObjectContext, type: T.Type) -> T? {
        var props = [String: Any]()

        props["image"] = purchase.image
        if let purchaseDate = purchase.purchaseDate {
            props["transactionDate"] = purchaseDate
        }
        props["itemName"] = purchase.itemName
        props["transactionAmount"] = Double(purchase.price) ?? 0
        props["serial"] = purchase.serial
        props["productDescription"] = purchase.productDescription
        props["lastUpdate"] = Date()

        let predicate = NSPredicate(format: "serial = %@", purchase.serial)

        return find(type,
                    properties: props,
                    predicate: predicate,
                    sortDescriptors: nil,
                    createIfNotFound: true)?.first
    }
    
    // MARK: - Refund
    func refund<T: NSManagedObject>(from refund: RefundJSON, context: NSManagedObjectContext, type: T.Type) -> T? {
        var props = [String: Any]()

        props["image"] = refund.image
        if let refundDate = refund.refundDate {
            props["transactionDate"] = refundDate
        }
        props["itemName"] = refund.itemName
        props["transactionAmount"] = Double(refund.refundAmount) ?? 0
        props["serial"] = refund.serial
        props["productDescription"] = refund.productDescription
        props["lastUpdate"] = Date()

        let predicate = NSPredicate(format: "serial = %@", refund.serial)

        return find(type,
                    properties: props,
                    predicate: predicate,
                    sortDescriptors: nil,
                    createIfNotFound: true)?.first
    }
}
    

