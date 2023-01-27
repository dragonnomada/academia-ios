//
//  AddPresenter.swift
//  8501_Home
//
//  Created by MacBook  on 27/01/23.
//

import Foundation

class AddPresenter: NSObject {
    
    private let router: HomeAddRouter
    
    private let interactor: TodoInteractor
    
    var view: AddViewDelegate?
    
    init(router: HomeAddRouter, interactor: TodoInteractor) {
        
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.todoCreatedObserver), name: NSNotification.Name("home.service.todoCreated"), object: nil)
        
        self.view?.viewDidCreate()
        
    }
    
    @objc func todoCreatedObserver(notification: Notification) {
        
        if let todo = notification.object as? TodoEntity {
            
            self.view?.todos(todoCreated: todo)
            
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
    
    func createTodo(title: String) {
        
        self.interactor.createTodo(title: title)
        
    }
    
}
