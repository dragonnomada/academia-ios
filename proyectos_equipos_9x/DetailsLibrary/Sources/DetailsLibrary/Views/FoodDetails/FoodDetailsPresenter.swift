//
//  FoodDetailsPresenter.swift
//  FoodInfoApp
//
//  Created by MacBook on 27/01/23.
//
// addObserver = subscriptor y necesita los @objc
import Foundation

class FoodDetailsPresenter: NSObject {
    
    private let router: DetailsEditRouter
    
    private let interactor: FoodInteractor
    
    var view: FoodDetailsDelegate?
    
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
        
        self.view = FoodDetailsViewController()
        
        self.view?.presenter = self
        
        self.view?.viewWillCreate()
        
        // Me subscribo al notificador del servicio, que informa cual fue el food seleccionado
        NotificationCenter.default.addObserver(self, selector: #selector(self.foodSelectedObserver), name: NSNotification.Name("foodServiceFoodSelected"), object: nil)
        
        // Me subscribo al notificador del servicio que me indica cual fue el alimento modificado
        NotificationCenter.default.addObserver(self, selector: #selector(self.foodUpdatedObserver), name: NSNotification.Name("foodUpdatedService"), object: nil)
        
        self.view?.viewDidCreate()
        
    }
    
    @objc func foodSelectedObserver(notification: Notification) {
        
        if let foodSelected = notification.object as? FoodEntity {
            
            self.view?.food(foodSelected: foodSelected)
            
        }
        
    }
    
    @objc func foodUpdatedObserver(notification: Notification) {
        
        if let foodUpdated = notification.object as? FoodEntity {
            
            self.view?.food(foodUpdated: foodUpdated)
            
        }
        
    }
    
    func removeView() {
        
        self.view?.viewWillRemove()
        
        // Desubscribimos al
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("foodServiceFoodSelected"), object: nil)
        
        self.view = nil
        
    }
    
    func requestFoodSelected() {
        
        self.interactor.requestFoodSelected()
        
    }
    
    func goToEdit() {
        
        // Publico que quiero navegar a la vista edit
        NotificationCenter.default.post(name: NSNotification.Name("foodScene.goToEdit"), object: self)
        
    }
    
    
}
