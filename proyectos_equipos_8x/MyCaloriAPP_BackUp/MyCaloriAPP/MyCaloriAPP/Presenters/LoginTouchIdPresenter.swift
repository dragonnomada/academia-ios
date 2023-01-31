//
//  LoginTouchIdPresenter.swift
//  MyCaloriAPP
//
//  Created by User on 25/01/23.
//

import Foundation
import UIKit

class LoginTouchIdPresenter {
    // Router
    weak var router: CaloriappRouter?
    // Interactor
    weak var interactor: UserInteractor?
    
    // View & ViewController
    weak var view: LoginTouchIdView?
    
    lazy var viewController: LoginTouchIdViewController = {
        let viewController = LoginTouchIdViewController()
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
    
    func gotoLoginPassword() {
        self.router?.openLoginPassword()
    }
    
    func gotoHome() {
        self.router?.openHomeTabBar()
    }
    
    func gotoDefaultLogin() {
        self.router?.backToDefaultLogin()
    }
    
}
