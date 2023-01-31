//
//  SigninAPresenter.swift
//  MyCaloriAPP
//
//  Created by User on 25/01/23.
//

import Foundation
import UIKit

class SigninAPresenter {
    // Router
    weak var router: CaloriappRouter?
    // Interactor
    weak var interactor: UserInteractor?
    
    // View & ViewController
    weak var view: SigninAView?
    
    lazy var viewController: SigninAViewController = {
        let viewController = SigninAViewController()
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
    
    func gotoSigninB() {
        self.router?.openSigninB()
    }
    
    func gotoLoginA() {
        self.router?.closeSigninA()
    }
}
