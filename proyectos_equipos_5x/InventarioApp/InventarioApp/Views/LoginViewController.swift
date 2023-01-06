//
//  LoginViewController.swift
//  InventarioApp
//
//  Created by MacBook  on 04/01/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    
    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        InventarioController.shared.inventarioLoginDelegate = self
    }
    
    @IBAction func submitClicked(_ sender: Any){
        guard let usuario = usuarioTextField.text else { return }
        
        guard let password = passwordTextField.text else { return }
        
        InventarioController.shared.getUsuario(nombre: usuario, password: password)
    }
   
}

extension LoginViewController: InventarioLoginDelegate {
    func login(usuarioIniciado: UsuarioEntity) {
        performSegue(withIdentifier: "Login-Home-Segue", sender: self)
    }
    
    func loginError(loginError error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        
        self.present(alert, animated: true)
    }
    
    
}
