//
//  FoodScene.swift
//  HomeModule
//
//  Created by User on 27/01/23.
//

import Foundation
import UIKit

class HomeModuleScene: NSObject {
    
    let interactor = FoodInteractor()
    
    let router = HomeModuleRouter()
    
    lazy var homePresenter: HomePresenter = {
        
        let presenter = HomePresenter(router: self.router, interactor: self.interactor)
        
        return presenter
        
    }()
    
    lazy var addPresenter: AddPresenter = {
        
        let presenter = AddPresenter(router: self.router, interactor: self.interactor)
        
        return presenter
        
    }()
    
    func createScene(window: UIWindow?) {
        
        window?.rootViewController = self.router.navigationController
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.goToAdd), name: NSNotification.Name("homeModuleScene.goToAdd"), object: nil)
        
    }
    
    @objc func goToAdd(notification: Notification) {
        
        self.openAdd()
        
    }
    
    // Otros presenters
    
    func openHome() {
        
        self.homePresenter.openHome()
        
    }
    
    func closeHome() {
        
        self.homePresenter.closeHome()
        
    }
    
    func openAdd() {
        
        self.addPresenter.openAdd()
        
    }
    
    /*func closeAdd() {
        
        self.addPresenter.closeAdd()
        
    }*/
    
}
