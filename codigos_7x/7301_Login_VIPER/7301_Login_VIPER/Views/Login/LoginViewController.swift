//
//  LoginViewController.swift
//  7301_Login_VIPER
//
//  Created by Dragon on 18/01/23.
//

import UIKit

class LoginViewController: UIViewController {

    weak var presenter: LoginPresenter?
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    deinit {
        print("LIBERANDO LoginViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInAction() {
        
        guard let username = usernameTextField.text else {
            print("No hay username")
            return
        }
        
        guard !username.isEmpty else {
            print("El username está vacío")
            return
        }
        
        guard let password = passwordTextField.text else {
            print("No hay password")
            return
        }
        
        guard !password.isEmpty else {
            print("El password está vacío")
            return
        }
        
        guard password.count >= 4 else {
            print("El password tiene menos de 4 caracteres")
            return
        }
        
        Task {
            print("Iniciando sesión desde la vista [\(username)]")
            print("Hay presenter? \(self.presenter != nil ? "SI" : "NO")")
            await self.presenter?.signIn(username: username, password: password)
        }
        
    }

}

extension LoginViewController: LoginView {
    
    func login(userSignIn: UserEntity) {
        
        // TODO: Responder a cuándo el usuario inicia sesión
        print("El usuario inició sesión")
        
        let alert = UIAlertController(title: "Sesión iniciada", message: "Bienvenido", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: {
            
            [weak self] _ in
        
            self?.presenter?.goToHome()
            
        }))
        
        self.present(alert, animated: true)
        
    }
    
    func login(willOpen: Bool) {
        print("Se ha abierto la vista de LoginViewController")
    }
    
}
