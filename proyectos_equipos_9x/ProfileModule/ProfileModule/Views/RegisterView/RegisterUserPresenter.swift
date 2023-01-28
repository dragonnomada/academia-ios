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
        
        
        self.view?.viewDidCreate()
    }
    
    
    func removeView() {
        
        self.view?.viewWillRemove()
        
        
        
        self.view = nil
        
    }
    
}
