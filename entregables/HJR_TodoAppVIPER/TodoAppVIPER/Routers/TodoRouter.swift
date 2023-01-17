//
//  TodoRouter.swift
//  TodoAppVIPER
//
//  Created by MacBook on 16/01/23.
//

import Foundation
import UIKit

class TodoRouter: NSObject, UINavigationControllerDelegate {
    
    lazy var navigationController: UINavigationController = {
        
        print("Creando un NavigationController")
        
        let navigationController = UINavigationController()
        
        return navigationController
        
    }()
    
    lazy var interactor: TodoInteractor = {
        
        print("Creando un TodoInteractor")
        
        let interactor = TodoInteractor()
        
        print("Configurando el interactor")
        
        return interactor
        
    }()
    
    lazy var homePresenter: TodoHomePresenter = {
        
        print("Creando el TodoHomePresenter")
        
        let presenter = TodoHomePresenter()
        
        print("Configurando el presentador")
        
        presenter.router = self
        
        return presenter
        
    }()
    
    /*
    lazy var addPresenter: TodoAddPresenter = {
        
        print("Creando el TodoAddPresenter")
        
        let presenter = TodoAddPresenter()
        
        print("Configurando el presentador")
        
        presenter.router = self
        
        return presenter
        
    }()
    
    lazy var detailsPresenter: TodoDetailsPresenter = {
        
        print("Creando el TodoDetailsPresenter")
        
        let presenter = TodoDetailsPresenter()
        
        print("Configurando el presentador")
        
        presenter.router = self
        
        return presenter
        
    }()
    
    lazy var editPresenter: TodoEditPresenter = {
        
        print("Creando el TodoEditPresenter")
        
        let presenter = TodoEditPresenter()
        
        print("Configurando el presentador")
        
        presenter.router = self
        
        return presenter
        
    }()*/
    
    // Navigations
    
    func openTodoHome() {
        
        print("Abriendo TodoHome")
        
        self.homePresenter.connectInteractor(interactor: self.interactor)
        
        self.navigationController.pushViewController(homePresenter.viewController, animated: false)
        
    }
    /*
    func openTodoAdd() {
        
        print("Abriendo TodoAdd")
        
        self.addPresenter.connectInteractor(interactor: self.interactor)
        
        self.navigationController.pushViewController(addPresenter.viewController, animated: true)
        
    }
    
    func closeTodoAdd() {
        
        print("Cerrando TodoAdd")
        
        self.navigationController.popViewController(animated: true)
        
        self.addPresenter.disconnectInteractor()
        
    }
    
    func openTodoDetails() {
        
        print("Abriendo TodoDetails")
        
        self.detailsPresenter.connectInteractor(interactor: self.interactor)
        
        self.navigationController.pushViewController(detailsPresenter.viewController, animated: true)
        
    }
    
    func closeTodoDetails() {
        
        print("Cerrando TodoDetails")
        
        self.navigationController.popViewController(animated: true)
        
        self.detailsPresenter.disconnectInteractor()
        
    }
    
    func openTodoEdit() {
        
        print("Abriendo TodoEdit")
        
        self.editPresenter.connectInteractor(interactor: self.interactor)
        
        self.navigationController.pushViewController(editPresenter.viewController, animated: true)
        
    }
    
    func closeTodoEdit(animated: Bool) {
        
        print("Cerrando TodoEdit")
        
        self.navigationController.popViewController(animated: animated)
        
        self.editPresenter.disconnectInteractor()
        
    }*/
    
}

