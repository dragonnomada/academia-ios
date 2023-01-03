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
        
        TodoController.shared.addDelegate = self
    }
    
    @IBAction func addTodoAction(_ sender: Any) {
        if let title = titleTextField.text {
            TodoController.shared.addTodo(title: title)
        }
    }

}

extension TodoAddViewController: TodoAddDelegate {
    
    func todo(todoCreated todo: TodoEntity) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func todo(todoCreateError message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        self.present(alert, animated: true)
    }
    
}
