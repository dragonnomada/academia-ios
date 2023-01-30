//
//  HomePresenter.swift
//  HomeModule
//
//  Created by User on 27/01/23.
//

import Foundation

class HomePresenter: NSObject {
    
    private let router: HomeModuleRouter
    
    private let interactor: FoodInteractor
    
    var view: HomeViewDelegate?
    
    init(router: HomeModuleRouter, interactor: FoodInteractor) {
        
        self.router = router
        self.interactor = interactor
        
    }
    
    func openHome() {
        
        self.router.openHome(presenter: self)
        
    }
    
    func closeHome() {
        
        self.router.closeHome(presenter: self)
        
    }
    
    func createView() {
        
        self.view = HomeViewController()
        
        self.view?.presenter = self
        
        self.view?.viewWillCreate()
        
        // Subscribe interactor events
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.foodsObserver), name: NSNotification.Name("food.service.foods"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.filteredFoodsObserver), name: NSNotification.Name("food.service.filteredFoods"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.selectedFoodObserver), name: NSNotification.Name("food.service.selectedFood"), object: nil)
        
        self.view?.viewDidCreate()
        
    }
    
    @objc func foodsObserver(notification: Notification) {
        
        if let foods = notification.object as? [FoodEntity] {
            
            self.view?.foods(foods: foods)
            
        }
        
    }
    
    @objc func filteredFoodsObserver(notification: Notification) {
        
        if let filteredFoods = notification.object as? [FoodEntity] {
            
            self.view?.foods(filteredFoods: filteredFoods)
            
        }
        
    }
    
    @objc func selectedFoodObserver(notification: Notification) {
        
        if let selectedFood = notification.object as? FoodEntity {
            
            self.view?.foods(selectedFood: selectedFood)
        }
    }
    
    func removeView() {
        
        self.view?.viewWillRemove()
        
        // Unsubscribe interactor events
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("food.service.foods"), object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("food.service.filteredFoods"), object: nil)
        
        self.view = nil
        
    }
    
    func requestFoods() {
        
        self.interactor.requestFoods()
    }
    
    func searchFoods(byKeyword keyword: String) {
        
        self.interactor.searchFoods(keyword)
    }
    
    func selectFood(byIndex: Int, inFoods: [FoodEntity]) {
        
        self.interactor.selectFood(byIndex: byIndex, inFoods: inFoods)
    }
    
    func goToAdd() {
        
        NotificationCenter.default.post(name: NSNotification.Name("homeModuleScene.goToAdd"), object: self)
        
    }
    
}
