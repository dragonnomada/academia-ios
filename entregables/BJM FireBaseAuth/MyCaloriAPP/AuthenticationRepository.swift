//
//  AuthenticationRepository.swift
//  MyCaloriAPP
//
//  Created by User on 20/01/23.
//

import Foundation

class AuthenticationRepository {
    
    @Published var user: User?
    @Published var messageError: String?
    
    let authenticationFireBaseDataSource: AuthenticationFireBaseDataSource
    
    init(authenticationFireBaseDataSopurce: AuthenticationFireBaseDataSource) {
        self.authenticationFireBaseDataSopurce = authenticationFireBaseDataSopurce
    }
    
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        
        authenticationFireBaseDataSource.createNewUser(email: email, password: password) {
            
            [weak self] result in
            
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
}
