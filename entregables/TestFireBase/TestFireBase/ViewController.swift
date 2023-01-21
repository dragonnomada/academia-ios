//
//  ViewController.swift
//  TestFireBase
//
//  Created by MacBook on 20/01/23.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Login"
    }
 
    @IBAction func loginActionButton(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) {
                (result, error) in
                
                if let result = result, error == nil {
                    
                    self.navigationController?.pushViewController(HomeViewController(email: result.user.email!, provider: .email_password ), animated: true)
                    
                } else {
                    
                    let alert = UIAlertController(title: "Error", message: "Erro", preferredStyle: .alert )
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
        }
        
    }
    
    @IBAction func registerActionButtton(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) {
                (result, error) in
                
                if let result = result, error == nil {
                    
                    self.navigationController?.pushViewController(HomeViewController(email: result.user.email!, provider: .email_password ), animated: true)
                    
                } else {
                    
                    let alert = UIAlertController(title: "Error", message: "Erro", preferredStyle: .alert )
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
        }
        
    }
    
}

