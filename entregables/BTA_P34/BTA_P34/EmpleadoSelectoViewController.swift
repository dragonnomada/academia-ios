//
//  EmpleadoSelectoViewController.swift
//  BTA_P34
//
//  Created by MacBook Pro on 22/12/22.
//

import UIKit
import Combine

class EmpleadoSelectoViewController: UIViewController {
    
    var empleadoSubject : PassthroughSubject<Empleado, Never>?

    var empleadoSeleccionado: Empleado?

    
    
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var nombreTextField: UITextField!
    
    @IBOutlet weak var edadTextField: UITextField!
    
    @IBOutlet weak var puestoTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.text = "\(empleadoSeleccionado!.id)"
        nombreTextField.text = "\(empleadoSeleccionado!.nombre)"
        edadTextField.text = "\(empleadoSeleccionado!.edad)"
        puestoTextField.text = "\(empleadoSeleccionado!.puesto)"
    }
    

    @IBAction func cancelarAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func guardarAction(_ sender: Any) {
        
        let id: Int = Int(idTextField.text!)!
        let nombre: String = nombreTextField.text!
        let edad: Int = Int(edadTextField.text!)!
        let puesto: String = puestoTextField.text!
        
        let empleadoActualizado = Empleado(id: id, nombre: nombre, edad: edad, puesto: puesto)
        
        if let empleadoSubject = empleadoSubject {
            empleadoSubject.send(empleadoActualizado)
        }
        dismiss(animated: true)
    }
}
