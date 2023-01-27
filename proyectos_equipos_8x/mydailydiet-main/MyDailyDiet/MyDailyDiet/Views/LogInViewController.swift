//
//  LogInViewController.swift
//  MyDailyDiet
//
//  Created by MacBook on 24/01/23.
//

import UIKit

class LogInViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInRememberSwitch: UISwitch!
    
    weak var presenter: LoginUserPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
        print("Solicitando al presenter ir a la pantalla de registro de usuario")
        
        print("[LoginViewController] Presenter? \(self.presenter != nil ? "SI" : "NO")")
        
        self.presenter?.goToRegisterUser()
        
    }
    
    @IBAction func signInButton(_ sender: Any) {
        
        guard let email = self.emailTextField.text else {
            return
        }
        
        guard let password = self.passwordTextField.text else {
            return
        }
        
        Task {
            
            print("Iniciando Sesión")
            self.presenter?.LogInUser(email: email, password: password, active: signInRememberSwitch.isOn)
            
        }
    }
    
}

extension LogInViewController: LoginView {
    
    func user(LogInUser: UserAuthEntity) {
        print("Se ha logueado un usuario")
    }
    
}
