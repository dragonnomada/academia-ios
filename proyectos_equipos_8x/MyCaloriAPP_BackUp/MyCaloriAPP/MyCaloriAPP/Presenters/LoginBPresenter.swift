//
//  LoginBPresenter.swift
//  MyCaloriAPP
//
//  Created by User on 25/01/23.
//

import Foundation
import UIKit

class LoginBPresenter {
    // Router
    weak var router: CaloriappRouter?
    
    // Interactor
    weak var interactor: UserInteractor?
    
    // View & ViewController
    weak var view: LoginBView?
    
    lazy var viewController: LoginBViewController = {
        let viewController = LoginBViewController()
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
    
    func closeLoginB() {
        self.router?.closeLoginB()
    }
    
}
