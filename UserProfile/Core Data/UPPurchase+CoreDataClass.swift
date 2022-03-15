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
public class UPPurchase: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case image
        case purchaseDate = "purchase_date"
        case itemName = "item_name"
        case price,
             serial
        case productDescription = "description"
        case user
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw UPError.missingManagedObjectContext
        }

        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.image = try container.decode(String.self, forKey: .image)
        self.purchaseDate = try container.decode(Date.self, forKey: .purchaseDate)
        self.itemName = try container.decode(String.self, forKey: .itemName)
        self.price = try Double(container.decode(String.self, forKey: .price)) ?? 0
        self.serial = try container.decode(String.self, forKey: .serial)
        self.productDescription = try container.decode(String.self, forKey: .productDescription)
        self.lastUpdate = Date()
        self.user = nil
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(image, forKey: .image)
        try container.encode(purchaseDate, forKey: .purchaseDate)
        try container.encode(itemName, forKey: .itemName)
        try container.encode(price, forKey: .price)
        try container.encode(serial, forKey: .serial)
        try container.encode(productDescription, forKey: .productDescription)
        try container.encode(user, forKey: .user)
    }
}

// MARK: - Formats
extension UPPurchase {
    var priceFormatted: String {
        return String.format(usd: price)
    }
    
    var purchaseDateFormatted: String? {
        guard let purchaseDate = purchaseDate else {
            return nil
        }
        
        return String.format(date: purchaseDate, with: Constants.normalDate)
    }
}
