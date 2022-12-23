/*
 Heber Eduardo Jimenez Rodriguez
 
 Creado el 22-12-22
 
 Práctica 34 - Uso del Framework Combine
 */

import UIKit
import Combine

class EmpleadosDetallesViewController: UIViewController {
    
    
    var empleadoSubject: PassthroughSubject<Empleado, Never>?
    
    // Variable que pasara al empleado del ViewController
    var empleadoSeleccionado: Empleado?
    
    // IBOutlet de los textField donde se mostrara y modificara la infromacion
    // de los empleados
    @IBOutlet weak var nombreTextField: UITextField!
    
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var puestoTextFiedl: UITextField!
    
    @IBOutlet weak var edadTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.text = "\(empleadoSeleccionado!.id)"
        nombreTextField.text = "\(empleadoSeleccionado!.nombre)"
        edadTextField.text = "\(empleadoSeleccionado!.edad)"
        puestoTextFiedl.text = "\(empleadoSeleccionado!.puesto)"
    }
    
    @IBAction func cancelarAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func guardarAction(_ sender: Any) {

        //let id: Int = Int(idTextField.text!)!
        // Indicamos que el id no sea modificable por el usuario
        let id: Int = empleadoSeleccionado?.id ?? 0
        let nombre: String = nombreTextField.text!
        let edad: Int = Int(edadTextField.text!)!
        let puesto: String = puestoTextFiedl.text!
        
        let empleadoActualizado = Empleado(id: id, nombre: nombre, puesto: puesto, edad: edad)
        
        if let empleadoSubject = empleadoSubject {
            empleadoSubject.send(empleadoActualizado)
        }
        dismiss(animated: true)
    }
}
