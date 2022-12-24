//
//  ViewController.swift
//  E33302_MVVM
//
//  Created by MacBook Pro on 23/12/22.
//

import UIKit
import Combine

class ViewController: UIViewController {

    
    
    @IBOutlet weak var correoTextField: UITextField!
    
    
    @IBOutlet weak var contraseñaTextField: UITextField!
    
    var usuarioAutenticadoSubscriber: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        usuarioAutenticadoSubscriber = LoginViewModel.shared.usuarioAutenticadoSubject.sink {
            usuario in
            self.performSegue(withIdentifier: "welcomeSegue", sender: usuario)
        }
    }
    
    
    @IBAction func iniciarSesionAction(_ sender: Any) {
        if let correo = correoTextField.text, let contraseña = contraseñaTextField.text {
            print("Enviando \(correo) \(contraseña)")
            LoginViewModel.shared.iniciaSesionSubject.send((correo: correo, contraseña: contraseña))
            
        }
        
    }
    

}

