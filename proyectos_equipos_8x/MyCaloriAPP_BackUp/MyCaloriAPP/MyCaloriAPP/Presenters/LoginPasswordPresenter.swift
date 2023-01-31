//
//  LoginPasswordPresenter.swift
//  MyCaloriAPP
//
//  Created by User on 25/01/23.
//

import Foundation
import UIKit

class LoginPasswordPresenter {
    // Router
    weak var router: CaloriappRouter?
    
    // Interactor
    weak var interactor: UserInteractor?
    
    // View & ViewController
    weak var view: LoginPasswordView?
    
    lazy var viewController: LoginPasswordViewController = {
        let viewController = LoginPasswordViewController()
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
    
    func gotoHome() {
        self.router?.openHomeTabBar()
    }
    
    func gotoDefaultLogin() {
        self.router?.backToDefaultLogin()
    }
}
