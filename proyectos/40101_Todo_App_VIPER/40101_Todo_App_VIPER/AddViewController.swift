//
//  AddViewController.swift
//  40101_Todo_App_VIPER
//
//  Created by Dragon on 26/12/22.
//

import UIKit

class AddViewController: TodoAddViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addTodoAction(_ sender: Any) {
        print(presenter)
        if let presenter = self.presenter, let text = self.textField.text {
            presenter.interactor.addTodo(title: text)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
