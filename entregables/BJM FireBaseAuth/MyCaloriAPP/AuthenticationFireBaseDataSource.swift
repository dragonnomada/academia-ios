//
//  AuthenticationFireBaseDataSource.swift
//  MyCaloriAPP
//
//  Created by User on 20/01/23.
//

import Foundation
import FirebaseAuth

struct User {
    
    let email: String
}

class AuthenticationFireBaseDataSource {
    
    func createNewUser (email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) {
            
            AuthDataResult, error in
            
            if let error = error {
                
                print("Error \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            } else {
                
                let email = AuthDataResult?.user.email ?? "No email"
                print("Nuevo usuario registrado con \(email)")
                completionBlock(.success(.init(email: email)))
            }
        }
    }
}
