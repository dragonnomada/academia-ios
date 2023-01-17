//
//  TodoHomePresenter.swift
//  TodoAppVIPER
//
//  Created by MacBook on 16/01/23.
//

import Foundation
import Combine

class TodoHomePresenter {
    
    // Routers
    
    weak var router: TodoRouter?
    
    // Interactors
    
    weak var interactor: TodoInteractor?
    
    // View & ViewController
    
    weak var view: TodoHomeView?
    
    lazy var viewController: TodoHomeViewController = {
        let viewController = TodoHomeViewController()
        
        // TODO: Configuar el viewController
        viewController.presenter = self
        
        self.view = viewController
        
        return viewController
    }()
    
    // Subscribers
    
    var todosSubscriber: AnyCancellable?
    var todoSeleccionadoSubscriber: AnyCancellable?
    
    // Connects & Disconnects
    
    func connectInteractor(interactor: TodoInteractor) {
        self.interactor = interactor
        
        self.todosSubscriber = interactor.todosSubscriber.sink(receiveValue: {
            
            [weak self] todos in
            
            self?.view?.todo(todosCargadas: todos)
            
        })
    }
    
    func disconnectInteractor() {
        
        self.todosSubscriber?.cancel()
        self.todosSubscriber = nil
        
        self.todoSeleccionadoSubscriber?.cancel()
        self.todoSeleccionadoSubscriber = nil
        
        self.interactor = nil
        
    }
    
    // Functionallity
    
    func describir(_ mensaje: String) {
        print("[TodoHomePresenter] \(mensaje)")
    }
    
    // Operations
    
    func recargarTodos() {
        
        self.interactor?.recargarTodos()
        
    }
    
    func seleccionarTodo(index: Int) {
        
        //self.interactor?.seleccionarTodo(index: index)
        
    }
    
    func goAgregarTodo() {
        
        //self.router?.openTodoAdd()
        
    }
    
    func goDetallesTodo() {
        
        //self.router?.openTodoDetails()
        
    }
    
}
