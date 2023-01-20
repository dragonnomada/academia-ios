//
//  ViewController.swift
//  LoginExample
//
//  Created by MacBook on 20/01/23.
//

import UIKit
import FirebaseAnalytics
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var correoTextField: UITextField!
    
    @IBOutlet weak var contraseñaTextField: UITextField!
    
    
    @IBAction func loginButton(_ sender: Any) {
        
        if let email = correoTextField.text, let contraseña = contraseñaTextField.text {
            
            Auth.auth().signIn(withEmail: email, password: contraseña) {
                (result, error) in
                
                if let _ = result, error == nil {
                    
                    print("Un usuario se ha logueado")
                    
                } else {
                    
                    let alerta = UIAlertController(title: "Error", message: "Se ha producido un error de registro", preferredStyle: .alert)
                    alerta.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alerta, animated: true, completion: nil)
                    
                }
            }
        }
        
    }
    
    @IBAction func registrarButton(_ sender: Any) {
        
        if let email = correoTextField.text, let contraseña = contraseñaTextField.text {
            
            Auth.auth().createUser(withEmail: email, password: contraseña) {
                (result, error) in
                
                if let _ = result, error == nil {
                    
                    print("Se ha registrado un nuevo usuario")
                    
                } else {
                    
                    let alerta = UIAlertController(title: "Error", message: "Se ha producido un error de registro", preferredStyle: .alert)
                    alerta.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alerta, animated: true, completion: nil)
                    
                }
            }
        }
    }
    
}

