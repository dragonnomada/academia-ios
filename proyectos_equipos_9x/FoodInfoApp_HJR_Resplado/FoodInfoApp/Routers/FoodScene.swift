//
//  FoodScene.swift
//  FoodInfoApp
//
//  Created by MacBook on 27/01/23.
//

import Foundation
import UIKit

class FoodScene: NSObject {
    
    let interactor = FoodInteractor()
    
    let router = DetailsEditRouter()
    
    lazy var detailsPresenter: FoodDetailsPresenter = {
        
        let presenter = FoodDetailsPresenter(router: self.router, interactor: self.interactor)
        
        return presenter
        
    }()
    
    lazy var editPresenter: FoodEditPresenter = {
        
        let presenter = FoodEditPresenter(router: self.router, interactor: self.interactor)
        
        return presenter
        
    }()
    
    func createScene(window: UIWindow?) {
        
        window?.rootViewController = self.router.navigationController
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.goToEdit), name: NSNotification.Name("foodScene.goToEdit"), object: nil)
        
    }
    
    @objc func goToAdd(notification: Notification) {
        
        self.openAdd()
        
    }
    
    // Otros presenters
    
    func openHome() {
        
        self.detailsPresenter.openDetails()
        
    }
    
    func closeHome() {
        
        self.detailsPresenter.closeDetails()
        
    }
    
    func openAdd() {
        
        self.editPresenter.openAdd()
        
    }
    
}
