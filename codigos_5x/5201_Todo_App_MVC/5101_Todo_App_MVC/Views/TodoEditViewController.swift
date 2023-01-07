//
//  TodoEditViewController.swift
//  5101_Todo_App_MVC
//
//  Created by Dragon on 02/01/23.
//

import UIKit

class TodoEditViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var checkedSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TodoController.shared.editDelegate = self
        
        TodoController.shared.getSelectedTodo()
        
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        if let title = titleTextField.text {
            TodoController.shared.updateTodoTitle(title: title)
        }
        
        TodoController.shared.updateTodoCheck(checked: checkedSwitch.isOn)
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        
        TodoController.shared.deleteTodo()
        
    }

}

extension TodoEditViewController: TodoEditDelegate {
    
    func todo(todoUpdated todo: TodoEntity) {
        titleTextField.text = todo.title
        checkedSwitch.isOn = todo.checked
    }
    
    func todo(todoEdited todo: TodoEntity) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func todo(todoEditError message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        self.present(alert, animated: true)
    }
    
    func todo(todoDeleted todo: TodoEntity) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
