//
//  DetailEmpleadoViewController.swift
//  NJJ_P34
//
//  Created by MacBook on 22/12/22.
//

import UIKit
import Combine

class DetailEmpleadoViewController: UIViewController {
    
    
    
    var empleado: Empleado?

    
    @IBOutlet weak var nombreTextField: UITextField!
    
    
    @IBOutlet weak var puestoTextField: UITextField!
    
    
    @IBOutlet weak var sueldoTextField: UITextField!
    
    
    @IBAction func botonEnviar(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let empleado = empleado {
            nombreTextField.text = empleado.nombre
            puestoTextField.text = empleado.puesto
            sueldoTextField.text? = "\(empleado.sueldo)"
        }
    }
    

}
