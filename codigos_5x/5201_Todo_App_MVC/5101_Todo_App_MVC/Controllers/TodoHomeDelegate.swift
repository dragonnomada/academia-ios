//
//  TodoHomeDelegate.swift
//  5201_Todo_App_MVC
//
//  Created by Dragon on 03/01/23.
//

import Foundation

protocol TodoHomeDelegate {
    
    // tableView(numberOfSection section: Int)
    func todo(todosUpdated todos: [TodoEntity])
    
}
