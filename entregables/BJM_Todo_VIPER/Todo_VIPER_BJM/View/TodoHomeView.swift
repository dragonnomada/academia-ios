//
//  TodoHomeView.swift
//  Todo_VIPER_BJM
//
//  Created by User on 16/01/23.
//

import Foundation

protocol TodoHomeView: NSObject {
    
    // Delegates (consumers)
    
    func todo(todoSelected todo: TodoEntity)
}
