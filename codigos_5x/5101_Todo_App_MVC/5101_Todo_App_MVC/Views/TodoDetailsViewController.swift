//
//  TodoDetailsViewController.swift
//  5101_Todo_App_MVC
//
//  Created by Dragon on 02/01/23.
//

import UIKit

class TodoDetailsViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var checkedLabel: UILabel!
    @IBOutlet var createAtLabel: UILabel!
    @IBOutlet var updateAtLabel: UILabel!
    
    var todo: TodoEntity?
    var todoIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let todo = todo {
            titleLabel.text = todo.title ?? "Sín título"
            checkedLabel.text = todo.checked ? "✅" : "❌"
            createAtLabel.text = todo.createAt?.toString()
            createAtLabel.text = todo.updateAt?.toString()
        }
        
    }

}
