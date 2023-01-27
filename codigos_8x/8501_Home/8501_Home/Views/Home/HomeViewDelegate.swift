//
//  HomeViewDelegate.swift
//  8501_Home
//
//  Created by MacBook  on 27/01/23.
//

import Foundation
import UIKit

protocol HomeViewDelegate: UIViewController {
    
    var presenter: HomePresenter? { get set }
    
    func viewWillCreate()
    
    func viewDidCreate()
    
    func viewWillRemove()
    
    func todos(todosChecked todos: [TodoEntity])
    func todos(todosUnchecked todos: [TodoEntity])
    
    func todos(todoSelected todo: TodoEntity)
    
    func todos(todoSelectError error: TodoServiceError)
    
}

extension HomeViewDelegate {
    
    func viewWillCreate() {}
    
    func viewDidCreate() {}
    
    func viewWillRemove() {}
    
    func todos(todoSelectError error: TodoServiceError) {
        
        var message = "Undefined"
        
        switch error {
            
        case .selectTodo(let id):
            message = "Todo select error with id: \(id)"
            
        default:
            message = "\(error)"
            
        }
        
        let alert = UIAlertController(title: "Todo select error", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        self.present(alert, animated: true)
        
    }
    
}
