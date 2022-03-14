//
//  UPUser+CoreDataClass.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/14/22.
//
//

import Foundation
import CoreData

@objc(UPUser)
public class UPUser: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case userName = "user_name"
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case registration,
             image,
             purchases
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw UPError.missingManagedObjectContext
        }

        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try container.decode(String.self, forKey: .name)
        self.userName = try container.decode(String.self, forKey: .userName)
        self.fullName = try container.decode(String.self, forKey: .fullName)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.registration = try container.decode(Date.self, forKey: .registration)
        self.image = try container.decode(String.self, forKey: .image)
        self.lastUpdate = Date()
        self.purchases = NSSet()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(userName, forKey: .userName)
        try container.encode(fullName, forKey: .fullName)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(registration, forKey: .registration)
        try container.encode(purchases as! Set<UPPurchase>, forKey: .purchases)
    }
}

// MARK: - Formats
extension UPUser {
    var phoneNumberFormatted: String? {
        guard let p = phoneNumber else {
            return nil
        }

        // TODO: fix this
//        let p2 = String(format: "%@ (%@) %@ %@ %@", p.substringToIndex(p.startIndex.advancedBy(1)),
//            p.substringWithRange(p.startIndex.advancedBy(1) ... p.startIndex.advancedBy(3)),
//            p.substringWithRange(p.startIndex.advancedBy(4) ... p.startIndex.advancedBy(6)),
//            p.substringWithRange(p.startIndex.advancedBy(7) ... p.startIndex.advancedBy(8)),
//            p.substringWithRange(p.startIndex.advancedBy(9) ... p.startIndex.advancedBy(10))
//        )
        
        return nil
    }
    
    var registrationFormatted: String? {
        guard let registration = registration else {
            return nil
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        
        return formatter.string(from: registration)
    }
}
