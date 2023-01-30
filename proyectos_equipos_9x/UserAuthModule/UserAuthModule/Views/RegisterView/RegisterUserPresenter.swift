//
//  RegisterPresenter.swift
//  ProfileModule
//
//  Created by MacBook on 27/01/23.
//

import Foundation

class RegisterUserPresenter: NSObject {
    
    private let router: UserAuthRouter
    
    private let interactor: UserInteractor
    
    var view: RegisterUserDelegate?
    
    init(router: UserAuthRouter, interactor: UserInteractor) {
        self.router = router
        self.interactor = interactor
    }
    
    func openRegister() {
        
        self.router.openRegister(presenter: self)
        
    }
    
    func closeRegister() {
        
        self.router.closeRegister(presenter: self)
        
    }
    
    func createView() {
        
        self.view = RegisterUserViewController()
        
        self.view?.presenter = self
        
        self.view?.viewWillCreate()
        
        //Observers
        NotificationCenter.default.addObserver(self, selector: #selector(self.userRegisteredObserver), name: NSNotification.Name("user.service.userRegistered"), object: nil)
        
        self.view?.viewDidCreate()
    }
    
    @objc func userRegisteredObserver(notification: Notification) {
            
        if let userRegistered = notification.object as? UserAuthInfoEntity {
                
            self.view?.userRegister(userRegistered: userRegistered)
                
        }
            
    }
    
    
    func removeView() {
        
        self.view?.viewWillRemove()
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("user.service.userRegistered"), object: nil)
        
        self.view = nil
        
    }
    
    func registerUser(name: String, email: String, password: String, image: Data?) {
        
        self.interactor.createUser(name: name, email: email, password: password, image: image, dateRegister: Date.now)
        
    }
    
    func goToLogin() {
        
        NotificationCenter.default.post(name: NSNotification.Name("userAuthScene.goToLogin"), object: self)
        
    }
    
}
