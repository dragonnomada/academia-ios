//
//  FrutasRouter.swift
//  70101_FrutApp_VIPER
//
//  Created by Dragon on 16/01/23.
//

import Foundation
import UIKit

class FrutasRouter: NSObject, UINavigationControllerDelegate {
    
    lazy var navigationController: UINavigationController = {
        
        print("Creando un NavigationController")
        
        let navigationController = UINavigationController()
        
        /*DispatchQueue.main.async {
            print("Abriendo la pantalla FrutasHome")
            
            self.openFrutasHome()
        }*/
        
        return navigationController
        
    }()
    
    lazy var interactor: FrutasInteractor = {
        
        print("Creando un FrutasInteractor")
        
        let interactor = FrutasInteractor()
        
        print("Configurando el interactor")
        
        return interactor
        
    }()
    
    lazy var homePresenter: FrutasHomePresenter = {
        
        print("Creando el FrutasHomePresenter")
        
        let presenter = FrutasHomePresenter()
        
        print("Configurando el presentador")
        
        presenter.router = self
        
        return presenter
        
    }()
    
    lazy var addPresenter: FrutasAddPresenter = {
        
        print("Creando el FrutasAddPresenter")
        
        let presenter = FrutasAddPresenter()
        
        print("Configurando el presentador")
        
        presenter.router = self
        
        return presenter
        
    }()
    
    lazy var detailsPresenter: FrutasDetailsPresenter = {
        
        print("Creando el FrutasDetailsPresenter")
        
        let presenter = FrutasDetailsPresenter()
        
        print("Configurando el presentador")
        
        presenter.router = self
        
        return presenter
        
    }()
    
    lazy var editPresenter: FrutasEditPresenter = {
        
        print("Creando el FrutasEditPresenter")
        
        let presenter = FrutasEditPresenter()
        
        print("Configurando el presentador")
        
        presenter.router = self
        
        return presenter
        
    }()
    
    // Navigations
    
    func openFrutasHome() {
        
        print("Abriendo FrutasHome")
        
        self.homePresenter.connectInteractor(interactor: self.interactor)
        
        self.navigationController.pushViewController(homePresenter.viewController, animated: false)
        
    }
    
    func openFrutasAdd() {
        
        print("Abriendo FrutasAdd")
        
        self.addPresenter.connectInteractor(interactor: self.interactor)
        
        self.navigationController.pushViewController(addPresenter.viewController, animated: true)
        
    }
    
    func closeFrutasAdd() {
        
        print("Cerrando FrutasAdd")
        
        self.navigationController.popViewController(animated: true)
        
        self.addPresenter.disconnectInteractor()
        
    }
    
    func openFrutasDetails() {
        
        print("Abriendo FrutasDetails")
        
        self.detailsPresenter.connectInteractor(interactor: self.interactor)
        
        self.navigationController.pushViewController(detailsPresenter.viewController, animated: true)
        
    }
    
    func closeFrutasDetails() {
        
        print("Cerrando FrutasDetails")
        
        self.navigationController.popViewController(animated: true)
        
        self.detailsPresenter.disconnectInteractor()
        
    }
    
    func openFrutasEdit() {
        
        print("Abriendo FrutasEdit")
        
        self.editPresenter.connectInteractor(interactor: self.interactor)
        
        self.navigationController.pushViewController(editPresenter.viewController, animated: true)
        
    }
    
    func closeFrutasEdit(animated: Bool) {
        
        print("Cerrando FrutasEdit")
        
        self.navigationController.popViewController(animated: animated)
        
        self.editPresenter.disconnectInteractor()
        
    }
    
}
