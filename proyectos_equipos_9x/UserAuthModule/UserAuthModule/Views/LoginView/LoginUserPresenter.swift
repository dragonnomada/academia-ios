//
//  LoginUserPresenter.swift
//  ProfileModule
//
//  Created by MacBook on 27/01/23.
//

import Foundation


class LoginUserPresenter: NSObject {
    
    private let router: UserAuthRouter
    
    private let interactor: UserInteractor
    
    var view: LoginUserDelegate?
    
    init(router: UserAuthRouter, interactor: UserInteractor) {
        
        self.router = router
        
        self.interactor = interactor
        
    }
    
    func openLogin() {
        
        self.router.openLogin(presenter: self)
        
    }
    
    func closeLogin() {
        
        self.router.closeLogin(presenter: self)
        
    }
    
    func createView() {
        
        self.view = LoginUserViewController()
        
        self.view?.presenter = self
        
        self.view?.viewWillCreate()
        
        //Observers
        NotificationCenter.default.addObserver(self, selector: #selector(self.userLoggedObserver), name: NSNotification.Name("user.service.userLogged"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.userLoggedFailedObserver), name: NSNotification.Name("user.service.userLoggedError"), object: nil)
        
        
        self.view?.viewDidCreate()
    }
    
    @objc func userLoggedObserver(notification: Notification) {
        
            
        if let userLogged = notification.object as? UserAuthInfoEntity {
                
            self.view?.userLogged(userLogged: userLogged)
            
            print("Usuario Logeado")
                
        }
            
    }
    
    @objc func userLoggedFailedObserver(notification: Notification) {
        
            
        if let error = notification.object as? Error {
                
            self.view?.userLoggedFailed(userLoggedFailed: error)
            
            print("Usuario No Logeado")
                
        }
            
    }
    
    
    func removeView() {
        
        self.view?.viewWillRemove()
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("user.service.userLogged"), object: nil)
        
        self.view = nil
        
    }
    
    func goToRegister() {
        
        NotificationCenter.default.post(name: NSNotification.Name("userAuthScene.goToRegister"), object: self)

    }
    
    func loginUser(email: String, password: String) {
        
        self.interactor.logInUser(email: email, password: password)
        
//        NotificationCenter.default.post(name: NSNotification.Name("user.logged.succesfully"), object: self)
        
    }
    
}
