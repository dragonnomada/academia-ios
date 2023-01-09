//
//  TodoHomeViewModel.swift
//  6103_Todo_MVVM
//
//  Created by Dragon on 09/01/23.
//

import Foundation
import Combine

class TodoHomeViewModel {
    
    /// Son los `todos` para la vista
    @Published var todos: [TodoEntity] = []
    
    var todosSubscriber: AnyCancellable?
    
    init() {
        
        self.todosSubscriber = TodoModel.shared.$todos.dropFirst().sink {
            todos in
            self.todos = todos
        }
        
    }
    
    deinit {
        self.todosSubscriber?.cancel()
        self.todosSubscriber = nil
    }
    
    func loadTodos() {
        TodoModel.shared.loadTodos()
    }
    
}
