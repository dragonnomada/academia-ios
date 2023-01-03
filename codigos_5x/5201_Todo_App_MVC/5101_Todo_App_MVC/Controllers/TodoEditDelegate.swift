//
//  TodoEditDelegate.swift
//  5201_Todo_App_MVC
//
//  Created by Dragon on 03/01/23.
//

import Foundation

protocol TodoEditDelegate {
    
    func todo(todoUpdated todo: TodoEntity)
    
    func todo(todoEdited todo: TodoEntity)
    
    func todo(todoEditError message: String)
    
    func todo(todoDeleted todo: TodoEntity)
    
}
