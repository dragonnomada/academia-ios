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
        
        
        self.view?.viewDidCreate()
    }
    
    
    func removeView() {
        
        self.view?.viewWillRemove()
        
        
        
        self.view = nil
        
    }
    
}
