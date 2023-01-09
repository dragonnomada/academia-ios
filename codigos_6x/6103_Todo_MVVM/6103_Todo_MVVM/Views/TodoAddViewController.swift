//
//  TodoAddViewController.swift
//  6103_Todo_MVVM
//
//  Created by Dragon on 09/01/23.
//

import UIKit
import Combine

class TodoAddViewController: UIViewController {

    var addViewModel = TodoAddViewModel()
    
    @IBOutlet weak var titleTextField: UITextField!
    
    var todoAddedSubscriber: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.todoAddedSubscriber = self.addViewModel.$todoAdded.dropFirst().sink(receiveValue: { todo in
            if let todo = todo {
                print("TODO AGREGADO: \(todo)")
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    @IBAction func changeTitleAction() {
        if let title = self.titleTextField.text {
            print("Ajustando título: \(title)")
            self.addViewModel.setTitle(title: title)
        }
    }
    
    @IBAction func addTodoAction() {
        self.addViewModel.addTodo()
    }

}
