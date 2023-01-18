//
//  LoginInteractor.swift
//  7301_Login_VIPER
//
//  Created by Dragon on 18/01/23.
//

import Foundation
import Combine

class LoginInteractor {
    
    lazy var service: LoginService = {
        
        let service = LoginService()
        
        // TODO: Inicializar el servicio
        
        return service
        
    }()
    
    lazy var userSignInSubject: PassthroughSubject<UserEntity, Never> = {
        
        return self.service.userSignInSubject
        
    }()
    
    lazy var userSignOutSubject: PassthroughSubject<UserEntity, Never> = {
        
        return self.service.userSignOutSubject
        
    }()
    
    func requestUserLogged() {
        
        self.service.requestUserLogged()
        
    }
    
    func signIn(username: String, password: String) async {
        
        print("Llamando al servicio signIn")
        await self.service.signIn(username: username, password: password)
        
    }
    
    func signOut(confirm: () -> Bool) {
        
        if confirm() {
            self.service.signOut()
        }
        
    }
    
}
