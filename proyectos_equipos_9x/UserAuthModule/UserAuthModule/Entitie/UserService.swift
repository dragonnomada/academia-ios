//
//  UserService.swift
//  ProfileModule
//
//  Created by MacBook on 27/01/23.
//

// 27/01/2023
// updated by:
// Joel Brayan Navor Jimenez

import Foundation

//Enumerable para listar los errores que pueden surgir
enum UserAuthServiceErrors: Error {
    
    case loginUser(reason: String)
    case registerUser(reason: String)
    case saveContext(reason: String)
    case getUser(reason: String)
    
}

class UserAuthService {
    
    private let userAuthStorage = UserAuthStorage()
    
    private var userLogged: UserAuthInfoEntity?
    
    
    func createUser(name: String, email: String, password: String, image: Data?, dateRegister: Date) {
        
        if let newUser = self.userAuthStorage.createUser(email: email, name: name, password: password, image: image, dateRegister: dateRegister) {
            
            NotificationCenter.default.post(name: NSNotification.Name("User.Auth.Created"), object: newUser)
            
        } else {
            
            NotificationCenter.default.post(name: NSNotification.Name("User.Auth.Created"), object: UserAuthServiceErrors.registerUser(reason: "UserAuthStorageError"))
            
        }
        
    }
    
    func LogInUser(email: String, password: String) {
        
        let allUsers = self.userAuthStorage.getUsers()
        
        print(allUsers)
        
        if let userLogged = allUsers.filter({
            
            userLogged in
            
            userLogged.email == email && userLogged.password == password
            
        }).first {
            
            print("USUARIO INICIADO: \(userLogged)")
            
            NotificationCenter.default.post(name: NSNotification.Name("user.service.userLogged"), object: userLogged)
            
        } else {
            
            print("USUARIO NO INICIADO")
            
            NotificationCenter.default.post(name: NSNotification.Name("user.service.userLoggedError"), object: UserAuthServiceErrors.loginUser(reason: "User Loggin Failed, not user Register, not the right password or email"))
            
        }
        
    }
    
    func LogOutUser() {
        
        
        print("Sesión cerrada")
        self.userLogged = nil
         
        NotificationCenter.default.post(name: NSNotification.Name("User.Auth.Logout"), object: userLogged)
        
        
        }
        
    }
    
//}
