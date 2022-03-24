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
        props["purchaseDate"] = purchase.purchaseDate
        props["itemName"] = purchase.itemName
        props["price"] = Double(purchase.price) ?? 0
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
}
    

