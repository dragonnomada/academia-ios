//
//  LoginViewController.swift
//  InventarioApp
//
//  Created by MacBook  on 04/01/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    
    @IBOutlet weak var usuario: UITextField!
    @IBOutlet weak var password: UITextField
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitBtnClicked(_ sender: UIButton){
        getUsuario(nombre: String, password: String)
    }
   
}

extension LoginViewController: InventarioLoginDelegate {
    
}
