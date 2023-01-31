//
//  File.swift
//  
//
//  Created by MacBook  on 31/01/23.
//

import Foundation

protocol TodoHomeViewDelegate {
    
    var presenter: TodoHomePresenter? { get set }
    
    func willCreate()
    func didCreate()
    func willRemove()
    
    func todos(_ todos: [TodoEntity])
    
}

extension TodoHomeViewDelegate {
    
    func willCreate() {
        
        print("Se crea la ventana de TodoHome")
        
    }
    func didCreate() {
        
        print("Se creó la ventana de TodoHome")
        
    }
    func willRemove() {
        
        print("Se eliminó la ventana de TodoHome")
        
    }
    
}
