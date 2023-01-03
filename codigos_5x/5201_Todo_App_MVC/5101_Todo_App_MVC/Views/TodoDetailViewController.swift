//
//  TodoDetailsViewController.swift
//  5101_Todo_App_MVC
//
//  Created by Dragon on 02/01/23.
//

import UIKit

class TodoDetailViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var checkedLabel: UILabel!
    @IBOutlet var createAtLabel: UILabel!
    @IBOutlet var updateAtLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TodoController.shared.detailDelegate = self
        
        TodoController.shared.getSelectedTodo()
    }

}

extension TodoDetailViewController: TodoDetailDelegate {
    
    func todo(todoUpdated: TodoEntity) {
        
        if let todo = TodoController.shared.model.todoSelected {
            titleLabel.text = todo.title ?? "Sín título"
            checkedLabel.text = todo.checked ? "✅" : "❌"
            createAtLabel.text = todo.createAt?.toString()
            createAtLabel.text = todo.updateAt?.toString()
        }
        
    }
    
}
