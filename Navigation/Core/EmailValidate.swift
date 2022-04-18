//
//  EmailValidate.swift
//  Navigation
//
//  Created by Kirill Krasavin on 26.03.2022.
//

import Foundation

func emailValidate(for email: String) -> Bool {
    let emailPattern = #"^\S+@\S+\.\S+$"#

    let emailRegex = try! NSRegularExpression(
        pattern: emailPattern,
        options: []
    )
    
    let sourceRange = NSRange(
        email.startIndex ..< email.endIndex,
        in: email
    )
    
    let result = emailRegex.matches(
        in: email,
        options: [],
        range: sourceRange
    )

    return !result.isEmpty
}

