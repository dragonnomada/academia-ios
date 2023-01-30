//
//  UserAuthScene.swift
//  ProfileModule
//
//  Created by MacBook on 27/01/23.
//

import Foundation
import UIKit

class UserAuthScene: NSObject {
    
    let interactor = UserInteractor()
    
    let router = UserAuthRouter()
    
    lazy var registerUserPresenter: RegisterUserPresenter = {
        
        let presenter = RegisterUserPresenter(router: self.router, interactor:  self.interactor)
        
        return presenter
        
    }()
    
    lazy var loginUserPresenter: LoginUserPresenter = {
        
        let presenter = LoginUserPresenter(router: self.router, interactor: self.interactor)
        
        return presenter
        
    }()
    
    func createScene(window: UIWindow?) {
        
        window?.rootViewController = self.router.navigationController
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.goToRegister), name: NSNotification.Name("userAuthScene.goToRegister"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.goToLogin), name: NSNotification.Name("userAuthScene.goToLogin"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.userLogged), name: NSNotification.Name("user.logged, succesfully"), object: nil)
        
    }
    
    @objc func goToRegister(notification: Notification) {
        
        self.openRegister()
        
    }
    
    @objc func goToLogin(notification: Notification) {
        
        self.closeRegister()
        
    }
    
    @objc func userLogged(notification: Notification) {
        
        let alert = UIAlertController(title: "Succes", message: "User Logged Succesfully", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        //self.present(alert, animated: true)
        
    }
    
    
    func openLogin() {
        
        self.loginUserPresenter.openLogin()
        
    }
    
    func closeLogin() {
        
        self.loginUserPresenter.closeLogin()
        
    }
    
    func openRegister() {
        
        self.registerUserPresenter.openRegister()
        
    }
    
    func closeRegister() {
        
        self.registerUserPresenter.closeRegister()
        
    }
    
}
