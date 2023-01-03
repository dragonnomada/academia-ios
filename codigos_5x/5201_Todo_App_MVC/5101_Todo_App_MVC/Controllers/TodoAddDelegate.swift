//
//  TodoAddDelegate.swift
//  5201_Todo_App_MVC
//
//  Created by Dragon on 03/01/23.
//

import Foundation

protocol TodoAddDelegate {
    
    func todo(todoCreated todo: TodoEntity)
    
    func todo(todoCreateError message: String)
    
}
