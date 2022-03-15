//
//  Constants.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/14/22.
//

import Foundation

struct Constants {
    static let defaultUserName      = "@jennsmith"
    static let syncThresholdMinutes = 2
    static let managedObjectContext = "managedObjectContext"
    static let jsonDateFormat       = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    static let jsonLocale           = "en_US_POSIX"
    static let normalDate           = "MMMM d, yyyy"
    static let phonePattern         = "+# (###) ###-##-##"
}

enum UPError: LocalizedError {
    case statusCode
    case post
    case urlFormat
    case missingManagedObjectContext
    case dataNotFound
}
