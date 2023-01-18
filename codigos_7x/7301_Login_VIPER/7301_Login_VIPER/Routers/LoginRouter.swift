//
//  LoginRouter.swift
//  7301_Login_VIPER
//
//  Created by Dragon on 18/01/23.
//

import Foundation
import UIKit

class LoginRouter {
    
    // NavigationController
    
    lazy var navigationController: UINavigationController = {
        
        let navigationController = UINavigationController()
        
        // TODO: Configurar el navigationController
        //navigationController.navigationBar.backgroundColor = .blue
        
        return navigationController
        
    }()
    
    // Interactors
    
    lazy var interactor: LoginInteractor = {
        
        let interactor = LoginInteractor()
        
        // TODO: Configurar el interactor
        
        return interactor
        
    }()
    
    // Presenters
    
    var loginPresenter: LoginPresenter?
    var homePresenter: HomePresenter?
    
    // Navigators
    
    func openLogin() {
        
        // TODO: Inicializar el presenter de Login
        self.loginPresenter = LoginPresenter()
        
        self.loginPresenter?.open(router: self, interactor: self.interactor)
        
        if let viewController = self.loginPresenter?.view as? LoginViewController {
            
            //self.navigationController.popViewController(animated: true)
            
            var viewControllers = self.navigationController.viewControllers
            
            if viewControllers.count > 0 {
                viewControllers.insert(viewController, at: 0)
                self.navigationController.setViewControllers(viewControllers, animated: false)
                self.navigationController.popViewController(animated: true)
            } else {
                self.navigationController.setViewControllers([viewController], animated: false)
            }
            
            //self.navigationController.setViewControllers([viewController], animated: false)
            //self.navigationController.present(viewController, animated: true)
        }
        
    }
    
    func closeLogin() {
        
        // TODO: Deinicializar el presenter de Login
        self.loginPresenter?.close()
        
        self.loginPresenter = nil
        
    }
    
    func openHome() {
        
        print("Abriendo la página del Home desde el Router")
        
        // TODO: Inicializar el presenter de Home
        self.homePresenter = HomePresenter()
        
        self.homePresenter?.open(router: self, interactor: self.interactor)
        
        if let viewController = self.homePresenter?.view as? HomeViewController {
            
            self.navigationController.setViewControllers([viewController], animated: true)
        }
        
    }
    
    func closeHome() {
        
        // TODO: Deinicializar el presenter de Home
        self.homePresenter?.close()
        
        self.homePresenter = nil
        
    }
    
}
