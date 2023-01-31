//
//  FoodEditPresenter.swift
//  FoodInfoApp
//
//  Created by MacBook on 27/01/23.
//

import Foundation

class FoodEditPresenter: NSObject {
    
    private let router: DetailsEditRouter
    
    private let interactor: FoodInteractor
    
    var view: FoodEditDelegate?
    
    init(router: DetailsEditRouter, interactor: FoodInteractor) {
        
        self.router = router
        self.interactor = interactor
        
    }
    
    func openDetails() {
        
        self.router.openDetails(presenter: self)
        
    }
    
    func closeDetails() {
        
        self.router.closeDetails(presenter: self)
        
    }
    
    func createView() {
        
        self.view = FoodEditViewController()
        
        self.view?.presenter = self
        
        self.view?.viewWillCreate()
        
        // Subscribe interactor events
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.foodEditeddObserver), name: NSNotification.Name("foodServiceFoodSelected"), object: nil)
        
        self.view?.viewDidCreate()
        
    }
    
    @objc func foodEditeddObserver(notification: Notification) {
        
        if let food = notification.object as? FoodEntity {
            
            self.view?.food(foodEdited: food)
            
        }
        
    }
    
    func removeView() {
        
        self.view?.viewWillRemove()
        
        // No necesario porque marcamos weak
        // self.view?.presenter = nil
        
        // Unsubscribe interactor events
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.foodSelectedObserver), name: NSNotification.Name("foodServiceFoodSelected"), object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("home.service.todoCreated"), object: nil)
        
        self.view = nil
        
    }
    
    @objc func foodSelectedObserver(notification: Notification) {
        
        if let foodSelected = notification.object as? FoodEntity {
            
            self.view?.food(foodEdited: foodSelected)
            
        }
        
    }
    
    func requestFoodSelected() {
        self.interactor.requestFoodSelected()
    }
    
    func updateFood(name: String, calorias: Double, carbs: Double, fat: Double, fiber: Double, protein: Double, suggar: Double, units: Double) {
        
        self.interactor.updateFood(name: name, calorias: calorias, carbs: carbs, fat: fat, fiber: fiber, protein: protein, suggar: suggar, units: units)
        
    }
    
}
