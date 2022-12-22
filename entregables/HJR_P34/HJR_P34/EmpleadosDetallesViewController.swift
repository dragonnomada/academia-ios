//
//  EmpleadosDetallesViewController.swift
//  HJR_P34
//
//  Created by MacBook on 22/12/22.
//

import UIKit
import Combine

class EmpleadosDetallesViewController: UIViewController {
    
    
    var empleadoSubject = PassthroughSubject<[Empleado], Never>()
    
    // Variable que pasara al empleado del ViewController
    var empleado: Empleado?

    override func viewDidLoad() {
        super.viewDidLoad()
        //cargarDatos()
    }
    
    @IBOutlet weak var nombreTextField: UITextField!
    
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var puestoTextFiedl: UITextField!
    
    @IBOutlet weak var edadTextField: UITextField!
    
    /*
    func cargarDatos() {
        empleado?.nombre = nombreTextField
        empleado?.id = idTextField
        empleado?.puesto = puestoTextFiedl
        empleado?.edad = edadTextField
    }
     */
    
}
