//
//  RegisterUserViewController.swift
//  MyDailyDiet
//
//  Created by MacBook on 24/01/23.
//

import UIKit

class RegisterUserViewController: UIViewController {

    weak var presenter: RegisterUserPresenter? 
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var apellidoPaternoTextField: UITextField!
    
    @IBOutlet weak var apellidoMaternoTextField: UITextField!
    
    @IBOutlet weak var telefonoTextField: UITextField!
    
    @IBOutlet weak var alturaTextField: UITextField!
    
    @IBOutlet weak var pesoTextField: UITextField!
    
    @IBOutlet weak var emailTextFiedl: UITextField!
    
    @IBOutlet weak var confirmarEmailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmarPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func manButton(_ sender: Any) {
    }
    
    
    @IBAction func womanButton(_ sender: Any) {
    }
    
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
        
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
        guard let nombre = nameTextField.text else {
            
            self.showAlert(title: "Error", message: "Falta nombre")
            return
            
        }
        
        guard let email = emailTextFiedl.text else {
            self.showAlert(title: "Error", message: "Falta email")
            return
        }
        
        guard let password = passwordTextField.text else {
            self.showAlert(title: "Error", message: "Falta password")
            return
        }
        
        self.presenter?.registerUser(email: email, password: password, nombre: nombre)
        
    }
    

}


extension RegisterUserViewController: RegisterView {
    
    
}
