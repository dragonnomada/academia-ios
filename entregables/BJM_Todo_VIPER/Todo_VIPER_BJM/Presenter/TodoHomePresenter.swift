//
//  TodoHomePresenter.swift
//  Todo_VIPER_BJM
//
//  Created by User on 16/01/23.
//

import Foundation
import Combine

class TodoHomePresenter {
    
    // Router
    weak var router: TodoRouter?
    
    // Interactor
    weak var interactor: TodoInteractor?
    
    
    // View & ViewController
    weak var view: TodoHomeView?
    
    lazy var viewController: TodoHomeViewController = {
        
        let viewController = TodoHomeViewController()
        
        viewController.presenter = self
        self.view? = viewController
        
        return viewController
    }()
    
    // Suscriptores
    var todoSeleccionadoSubscriber: AnyCancellable?
    
    // Connect & Disconnect
    func connectInteractor(interactor: TodoInteractor) {
        self.interactor = interactor
        
        self.todoSeleccionadoSubscriber = interactor.todoSeleccionadoSubject.sink(receiveValue: {
            
            [weak self] todoSeleccionado in
            
            self?.view?.todo(todoSelected: todoSeleccionado)
            
        })
        
    }
    
    func disconnectInteractor() {
        
        self.todoSeleccionadoSubscriber?.cancel()
        self.todoSeleccionadoSubscriber = nil
        
        self.interactor = nil
        
    }
    
    // Operaciones
    
    func selectTodo(todo: TodoEntity) {
        
        self.interactor?.selectTodo(todo: todo)
    }
}
