//
//  SigninBPresenter.swift
//  MyCaloriAPP
//
//  Created by User on 25/01/23.
//

import Foundation
import UIKit

class SigninBPresenter {
    // Router
    weak var router: CaloriappRouter?
    // Interactor
    weak var interactor: UserInteractor?
    // View & ViewController
    weak var view: SigninBView?
    
    lazy var viewController: SigninBViewController = {
        let viewController = SigninBViewController()
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
    
    func gotoSigninA() {
        self.router?.closeSigninB()
    }
}
