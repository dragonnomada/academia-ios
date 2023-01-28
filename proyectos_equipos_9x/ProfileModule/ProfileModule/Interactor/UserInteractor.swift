//
//  UserInteractor.swift
//  ProfileModule
//
//  Created by MacBook on 27/01/23.
//

import Foundation

class UserInteractor {
    
    lazy var service: UserAuthService = {
        
        let service = UserAuthService()
        
        return service
        
    }()
    
    func createUser(name: String, email: String, password: String, image: Data, dateRegister: Date) {
        
        guard !name.isEmpty else {
            
            NotificationCenter.default.post(name: NSNotification.Name("User.Auth.service.ResgisterUserError"), object: UserAuthServiceErrors.registerUser(reason: "The name is Empty"))
            
            return
            
        }
        
        guard !email.isEmpty else {
            
            NotificationCenter.default.post(name: NSNotification.Name("User.Auth.service.ResgisterUserError"), object: UserAuthServiceErrors.registerUser(reason: "The email is Empty"))
            
            return
            
        }
        
        guard !password.isEmpty else {
            
            NotificationCenter.default.post(name: NSNotification.Name("User.Auth.service.ResgisterUserError"), object: UserAuthServiceErrors.registerUser(reason: "The password is Empty"))
            
            return
            
        }
        
        self.service.createUser(name: name, email: email, password: password, image: image, dateRegister: dateRegister)
        
    }
    
    func logInUser(email: String, password: String) {
        
        guard !email.isEmpty else {
            
            NotificationCenter.default.post(name: NSNotification.Name("User.Auth.service.ResgisterUserError"), object: UserAuthServiceErrors.registerUser(reason: "The email is Empty"))
            
            return
            
        }
        
        guard !password.isEmpty else {
            
            NotificationCenter.default.post(name: NSNotification.Name("User.Auth.service.ResgisterUserError"), object: UserAuthServiceErrors.loginUser(reason: "The password is Empty"))
            
            return
            
        }
        
        guard password.count >= 6 else {
            
            NotificationCenter.default.post(name: NSNotification.Name("User.Auth.service.LoginUserError"), object: UserAuthServiceErrors.loginUser(reason: "The password is lower than 6 digits"))
            
            return
        }
        
        self.service.LogInUser(email: email, password: password)
        
    }
    
    func LogOutUser() {
        
        self.service.LogOutUser()
        
    }
    
}


