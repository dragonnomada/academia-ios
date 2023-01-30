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
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.goToDetails), name: NSNotification.Name("foodCreatedService"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.closeEdit), name: NSNotification.Name("foodUpdatedService"), object: nil)
        
    }
    
    @objc func goToEdit(notification: Notification) {
        
        self.openEdit()
        
    }
    
    @objc func goToDetails(notification: Notification) {
        
        self.detailsPresenter.openDetails()
        
    }
    
    @objc func closeEdit(notification: Notification) {
        
        self.editPresenter.closeDetails()
        
    }
    
    // Otros presenters
    
    func openDetails(id: Int32, name: String, calorias: Double, carbs: Double, fat: Double, fiber: Double, protein: Double, suggar: Double, units: Double) {
        
        self.interactor.createFood(id: id, name: name, calorias: calorias, carbs: carbs, fat: fat, fiber: fiber, protein: protein, suggar: suggar, units: units)
        
    }
    
    func closeDetails() {
        
        self.detailsPresenter.closeDetails()
        
    }
    
    func openEdit() {
        
        self.editPresenter.openDetails()
        
    }
    
    
    
}
