//
//  TodoAddViewController.swift
//  5101_Todo_App_MVC
//
//  Created by Dragon on 02/01/23.
//

import UIKit

class TodoAddViewController: UIViewController {

    @IBOutlet var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addTodoAction(_ sender: Any) {
        if let title = titleTextField.text {
            TodoController.shared.addTodo(title: title, onTodoCreated: self)
        }
    }

}

extension TodoAddViewController: TodoCreatable {
    
    func onTodoCreated(todo: TodoEntity, todos: [TodoEntity]) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
