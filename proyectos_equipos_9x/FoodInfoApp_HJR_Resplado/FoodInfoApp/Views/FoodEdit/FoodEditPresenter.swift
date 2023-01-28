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
    
    func openAdd() {
        
        self.router.openAdd(presenter: self)
        
    }
    
    func closeAdd() {
        
        self.router.closeAdd(presenter: self)
        
    }
    
    func createView() {
        
        self.view = FoodEditViewController()
        
        self.view?.presenter = self
        
        self.view?.viewWillCreate()
        
        // Subscribe interactor events
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.todoCreatedObserver), name: NSNotification.Name("home.service.todoCreated"), object: nil)
        
        self.view?.viewDidCreate()
        
    }
    
    @objc func todoCreatedObserver(notification: Notification) {
        
        if let food = notification.object as? FoodEntity {
            
            self.view?.food(foodEdited: food)
            
        }
        
    }
    
    func removeView() {
        
        self.view?.viewWillRemove()
        
        // No necesario porque marcamos weak
        // self.view?.presenter = nil
        
        // Unsubscribe interactor events
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("home.service.todoCreated"), object: nil)
        
        self.view = nil
        
    }
    
    func updateFood(name: String, id: Int32, calorias: Double, carbs: Double, fat: Double, fiber: Double, protein: Double, suggar: Double, units: Double) {
        
        self.interactor.updateFood(name: name, id: id, calorias: calorias, carbs: carbs, fat: fat, fiber: fiber, protein: protein, suggar: suggar, units: units)
        
    }
    
}
