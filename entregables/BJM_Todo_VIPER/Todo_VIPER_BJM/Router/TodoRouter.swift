//
//  TodoRouter.swift
//  Todo_VIPER_BJM
//
//  Created by User on 16/01/23.
//

import Foundation
import UIKit

class TodoRouter: NSObject, UINavigationControllerDelegate {
    
    lazy var navigationController: UINavigationController = {
                
        let navigationController = UINavigationController()
        
        return navigationController
        
    }()
    
    lazy var interactor: TodoInteractor = {
                
        let interactor = TodoInteractor()
                
        return interactor
        
    }()
    
    lazy var homePresenter: TodoHomePresenter = {
                
        let presenter = TodoHomePresenter()
                
        presenter.router = self
        
        return presenter
        
    }()
    
    func openTodoHome() {
                
        self.homePresenter.connectInteractor(interactor: self.interactor)
        
        self.navigationController.pushViewController(homePresenter.viewController, animated: false)
    }
}
