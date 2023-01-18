//
//  LoginView.swift
//  7301_Login_VIPER
//
//  Created by Dragon on 18/01/23.
//

import Foundation

protocol LoginView: NSObject {
    
    var presenter: LoginPresenter? { get set }
    
    func login(willOpen: Bool)
    
    func login(willClose: Bool)
    
    func login(userSignIn: UserEntity)
    
}

extension LoginView {
    
    func login(willOpen: Bool) {
        print("Se abre login")
    }
    
    func login(willClose: Bool) {
        print("Se cierra login")
    }
    
}
