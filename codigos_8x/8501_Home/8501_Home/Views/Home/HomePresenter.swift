//
//  HomePresenter.swift
//  8501_Home
//
//  Created by MacBook  on 27/01/23.
//

import Foundation

class HomePresenter: NSObject {
    
    private let router: HomeAddRouter
    
    private let interactor: TodoInteractor
    
    var view: HomeViewDelegate?
    
    init(router: HomeAddRouter, interactor: TodoInteractor) {
        
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.todosCheckedObserver), name: NSNotification.Name("home.service.todosChecked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.todosUncheckedObserver), name: NSNotification.Name("home.service.todosUnchecked"), object: nil)
        
        self.view?.viewDidCreate()
        
    }
    
    @objc func todosCheckedObserver(notification: Notification) {
        
        if let todosChecked = notification.object as? [TodoEntity] {
            
            self.view?.todos(todosChecked: todosChecked)
            
        }
        
    }
    
    @objc func todosUncheckedObserver(notification: Notification) {
        
        if let todosUnchecked = notification.object as? [TodoEntity] {
            
            self.view?.todos(todosUnchecked: todosUnchecked)
            
        }
        
    }
    
    func removeView() {
        
        self.view?.viewWillRemove()
        
        // No necesario porque marcamos weak
        // self.view?.presenter = nil
        
        // Unsubscribe interactor events
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("home.service.todosChecked"), object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("home.service.todosUnchecked"), object: nil)
        
        self.view = nil
        
    }
    
    func requestTodos() {
        
        self.interactor.requestTodos()
        
    }
    
    func goToAdd() {
        
        NotificationCenter.default.post(name: NSNotification.Name("todoScene.goToAdd"), object: self)
        
    }
    
}
