//
//  DefaultLoginPresenter.swift
//  MyCaloriAPP
//
//  Created by User on 25/01/23.
//

import Foundation


class DefaultLoginPresenter {
    // Router
    weak var router: CaloriappRouter?
    
    // Interactor
    weak var interactor: UserInteractor?
    
    // View & ViewController
    weak var view: DefaultLoginView?
    
    lazy var viewController: DefaultLoginViewController = {
        let viewController = DefaultLoginViewController()
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
    
    func gotoLoginPassword() {
        self.router?.openLoginPassword()
    }
    
    func gotoLoginTouchId() {
        self.router?.openLoginTouchId()
    }
    
    func gotoLoginA() {
        self.router?.openLoginA()
    }
    
    func gotoSigninA() {
        self.router?.openSigninA()
    }
    
}
