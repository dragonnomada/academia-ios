//
//  TodoHomeView.swift
//  TodoAppVIPER
//
//  Created by MacBook on 16/01/23.
//

import Foundation

protocol TodoHomeView: NSObject {
    
    // Delegates (Consumers)
    
    func todo(todosCargadas todo: [TodoEntity])
    
    func todo(todoSeleccionado todo: TodoEntity, index: Int)
    
}
