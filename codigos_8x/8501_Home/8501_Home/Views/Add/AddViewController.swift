//
//  AddViewController.swift
//  8501_Home
//
//  Created by MacBook  on 27/01/23.
//

import UIKit

class AddViewController: UIViewController {

    weak var presenter: AddPresenter?
    
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addAction(_ sender: Any) {
        
        guard let title = titleTextField.text else {
            return
        }
        
        self.presenter?.createTodo(title: title)
        
    }
    
}

extension AddViewController: AddViewDelegate {
    
    func todos(todoCreated todo: TodoEntity) {
        
        self.presenter?.closeAdd()
        
    }
    
}
