//
//  AddPresenter.swift
//  HomeModule
//
//  Created by User on 27/01/23.
//

import Foundation

class AddPresenter: NSObject {
    
    private let router: HomeModuleRouter
    
    private let interactor: FoodInteractor
    
    var view: AddViewDelegate?
    
    init(router: HomeModuleRouter, interactor: FoodInteractor) {
        
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
        
        self.view = AddViewController()
        
        self.view?.presenter = self
        
        self.view?.viewWillCreate()
        
        // Subscribe interactor events
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.foodCreatedObserver), name: NSNotification.Name("food.service.foodCreated"), object: nil)
        
        self.view?.viewDidCreate()
        
    }
    
    @objc func foodCreatedObserver(notification: Notification) {
        
        if let food = notification.object as? FoodEntity {
            
            self.view?.foods(foodCreated: food)
            
        }
        
    }
    
    func removeView() {
        
        self.view?.viewWillRemove()
        
        // Unsubscribe interactor events
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("food.service.foodCreated"), object: nil)
        
        self.view = nil
        
    }
    
    func createFood(name: String, calories: Double, fats: Double, sugars: Double, fiber: Double, carbs: Double, proteins: Double, unit: String, factor: Double, image: Data?) {
        
        self.interactor.createFood(name: name, calories: calories, fats: fats, sugars: sugars, fiber: fiber, carbs: carbs, proteins: proteins, unit: unit, factor: factor, image: image)
        
    }
    
}
