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
    }
    
    @IBAction func submitClicked(_ sender: UIButton){
        performSegue(withIdentifier: "Login-Home-Segue", sender: self)
    }
   
}
