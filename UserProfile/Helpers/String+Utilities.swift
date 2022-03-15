//
//  String+Utilities.swift
//  UserProfile
//
//  Created by Vito Royeca on 3/15/22.
//

import Foundation

extension String {
    static func format(date: Date, with format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    static func format(usd: Double) -> String {
        return String(format: "$%.02f", usd)
    }
    
    static func format(phone: String, with pattern: String?) -> String {
        guard let pattern = pattern,
            !pattern.isEmpty else {
            return phone
        }
        
        let digit: Character = "#"
        let alphabetic: Character = "*"
        let newPattern: [Character] = Array(pattern)
        let allowedCharachters = CharacterSet.alphanumerics
        let filteredInput = String(phone.unicodeScalars.filter(allowedCharachters.contains))
        let input: [Character] = Array(filteredInput)
        var formatted: [Character] = []

        var patternIndex = 0
        var inputIndex = 0
        
        loop: while inputIndex < input.count {
            let inputCharacter = input[inputIndex]
            let allowed: CharacterSet
            
            guard patternIndex < pattern.count else {
                break loop
            }
            
            switch newPattern[patternIndex] {
            case digit:
                allowed = .decimalDigits
            case alphabetic:
                allowed = .letters
            default:
                formatted.append(newPattern[patternIndex])
                patternIndex += 1
                continue loop
            }
            
            guard inputCharacter.unicodeScalars.allSatisfy(allowed.contains) else {
                inputIndex += 1
                continue loop
            }
            
            formatted.append(inputCharacter)
            patternIndex += 1
            inputIndex += 1
        }
        
        return String(formatted)
    }
}
