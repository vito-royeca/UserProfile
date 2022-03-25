//
//  JSONData.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/23/22.
//

import Foundation

struct UserJSON: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case userName = "user_name"
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case registration,
             image
    }
    
    let name: String
    let userName: String
    let fullName: String
    let phoneNumber: String
    let registration: Date
    let image: String
}

struct PurchaseJSON: Codable {
    enum CodingKeys: String, CodingKey {
        case image
        case purchaseDate = "purchase_date"
        case itemName = "item_name"
        case price,
             serial
        case productDescription = "description"
    }
    
    let image: String?
    let  purchaseDate: Date?
    let itemName: String
    let price: String
    let serial: String
    let productDescription: String
}

struct RefundJSON: Codable {
    enum CodingKeys: String, CodingKey {
        case image
        case refundDate = "refund_date"
        case itemName = "item_name"
        case refundAmount = "refund_amt"
        case serial
        case productDescription = "description"
    }
    
    let image: String?
    let refundDate: Date?
    let itemName: String
    let refundAmount: String
    let serial: String
    let productDescription: String
}
