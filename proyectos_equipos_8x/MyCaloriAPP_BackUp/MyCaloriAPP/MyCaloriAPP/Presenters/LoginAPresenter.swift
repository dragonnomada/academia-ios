//
//  LoginAPresenter.swift
//  MyCaloriAPP
//
//  Created by User on 25/01/23.
//

import Foundation


class LoginAPresenter {
    // Router
    weak var router: CaloriappRouter?
    
    // Interactor
    weak var interactor: UserInteractor?
    
    // View & ViewController
    weak var view: LoginAView?
    
    lazy var viewController: LoginAViewController = {
        let viewController = LoginAViewController()
        viewController.presenter = self
        self.view = viewController
        return viewController
    }()
    
    // Connects & Disconnects
    
    func connectInteractor(interactor: UserInteractor) {
        
        self.interactor = interactor
   
    }
    
    func disconnectInteractor() {
        
        self.interactor = nil
        
    }

    // Operations
    
    func gotoSigninA() {
        self.router?.openSigninA()
    }
    
    func gotoLoginB() {
        self.router?.openLoginB()
    }
    
}
