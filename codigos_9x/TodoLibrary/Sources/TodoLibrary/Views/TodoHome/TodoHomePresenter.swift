//
//  File.swift
//  
//
//  Created by MacBook  on 31/01/23.
//

import Foundation
import UIKit

public class TodoHomePresenter: NSObject {
    
    var view: TodoHomeViewDelegate?
    
    var todoRouter: TodoRouter?
    var todoInteractor: TodoInteractor?
    
    func createView(router: TodoRouter, interactor: TodoInteractor) {
        
        self.todoRouter = router
        self.todoInteractor = interactor
        
        self.view = TodoHomeViewController(nibName: "TodoHomeViewController", bundle: Bundle.module)
        //self.view = HomeViewController()
        
        self.view?.willCreate()
        
        self.view?.presenter = self
        
        // SUBSCRIPTIONS
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.postTodosObserver), name: NSNotification.Name("TodoService.postTodos.success"), object: nil)
        
        self.view?.didCreate()
        
    }
    
    @objc func postTodosObserver(notification: Notification) {
        
        if let todos = notification.object as? [TodoEntity] {
            
            self.view?.todos(todos)
            
        } else {
            
            // TODO: Informar error a la vista
            
        }
        
    }
    
    func openTodoAdd() {
        
        NotificationCenter.default.post(name: NSNotification.Name("TodoScene.openTodoAdd"), object: nil)
        
    }
    
    func closeAll() {
        
        NotificationCenter.default.post(name: NSNotification.Name("TodoScene.closeAll"), object: nil)
        
    }
    
    public func requestTodos() {
        
        self.todoInteractor?.postTodos()
        
    }
    
    func removeView() {
        
        self.view?.willRemove()
        
        self.view = nil
        
    }
    
}
