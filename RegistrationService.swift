//
//  RegistrationService.swift
//  FireBaseTest
//
//  Created by Soham Kaje on 11/8/21.
//

import Combine
import Foundation
import Firebase
import FirebaseDatabase
//create an enum datatype to store generic values
enum RegistrationKeys: String {
    case firstName
    case lastName
    case Username
    case Count
    case CPS
}
//registration services protocol
protocol RegistrationService {
    func register(with details: RegistrationDetails) -> AnyPublisher<Void, Error>
}
//registration services Implementation
final class RegistrationServiceImpl: RegistrationService {
    func register(with details: RegistrationDetails) -> AnyPublisher<Void, Error>{
        
        Deferred {
            //creating user with email per firebase
            Future  { promise in
                Auth.auth().createUser(withEmail: details.email, password: details.password) { res, error in
                    if let err = error{
                        promise(.failure(err))
                    } else {
                        
                        if let uid = res?.user.uid{
                            //set our key values for the database
                            let values = [RegistrationKeys.firstName.rawValue: details.firstName,
                                          RegistrationKeys.lastName.rawValue: details.lastName,
                                          RegistrationKeys.Username.rawValue: details.Username,
                                          RegistrationKeys.Count.rawValue: details.Count
                            ] as [String: Any]
                                
                            Database.database()//pulls up the database
                                .reference()
                                .child("users")//find users in database
                                .child(uid)//use the user uid as a key
                                .updateChildValues(values) { error, ref in
                                    if let err = error {
                                        promise(.failure(err))
                                    } else {
                                        promise(.success(()))
                                }
                                    
                        }
                        } else {
                            promise(.failure(NSError(domain: "Invalid User Id", code: 0, userInfo: nil)))
                        }
                    }
                }
                
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
