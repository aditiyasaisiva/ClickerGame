//
//  RegistrationDetails.swift
//  FireBaseTest
//
//  Created by Soham Kaje on 11/4/21.
//

import Foundation

struct RegistrationDetails {
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var Username: String
    var Count: Double
    var CPS: Double
    
}

extension RegistrationDetails {
    
    static var new: RegistrationDetails {
        //copy the code below from RegistrationViewModel
        RegistrationDetails(email: "",
                            password: "",
                            firstName: "",
                            lastName: "",
                            Username: "",
                            Count: 0.0,
                            CPS: 0.0
                            
                            
                            )
    }
}
