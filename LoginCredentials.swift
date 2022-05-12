//
//  LoginCredentials.swift
//  FireBaseTest
//
//  Created by Soham Kaje on 11/19/21.
//

import Foundation

struct LoginCredentials {
    var email: String
    var password: String
}

extension LoginCredentials {
    static var new: LoginCredentials {
        LoginCredentials(email: "", password: "")
    }
}
