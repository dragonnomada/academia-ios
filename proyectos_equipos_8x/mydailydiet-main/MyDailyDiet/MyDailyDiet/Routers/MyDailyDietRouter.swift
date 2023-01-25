//
//  MyDailyDietRouter.swift
//  MyDailyDiet
//
//  Created by MacBook on 23/01/23.
//

import Foundation
import UIKit

class MyDailyDietRouter {
    
    lazy var navigationController: UINavigationController = {
        
        let navigationController = UINavigationController()
        
        return navigationController
        
    }()
    
    lazy var interactor: UserInteractor = {
        
        let interactor = UserInteractor()
        
        return interactor
        
    }()
    
    // Presentadores (1 por pantalla)
    
    var loginUserPresenter: LoginUserPresenter?
    var registerUserPresenter: RegisterUserPresenter?
    
    // Funciones que nos llevaran a las vistas 
    func goToLogin() {
        
        self.loginUserPresenter = LoginUserPresenter()
        
        self.loginUserPresenter?.start(router: self, interactor: self.interactor)
        
        if let viewController = self.loginUserPresenter?.view as? LoginViewController {
            
            self.navigationController.pushViewController(viewController, animated: false)
            
        }
    }
    
    func goToRegister() {
        
        self.registerUserPresenter = LoginUserPresenter()
        
        self.registerUserPresenter?.start(router: self, interactor: self.interactor)
        
        if let viewController = self.registerUserPresenter?.view as? RegisterUserViewController {
            
            self.navigationController.pushViewController(viewController, animated: false)
            
        }
    }
}
