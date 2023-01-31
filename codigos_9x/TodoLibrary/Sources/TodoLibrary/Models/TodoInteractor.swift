//
//  File.swift
//  
//
//  Created by MacBook  on 31/01/23.
//

import Foundation

@available(macOS 12, *)
public class TodoInteractor {
    
    lazy var todoService: TodoService = {
        
        let service = TodoService()
        
        service.generateSampleTodos()
        
        return service
        
    }()
    
    public func postTodos() {
        
        self.todoService.postTodos()
        
    }
    
}
