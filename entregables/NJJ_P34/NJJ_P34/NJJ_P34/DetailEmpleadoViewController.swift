//
//  DetailEmpleadoViewController.swift
//  NJJ_P34
// Joel Brayan Navor Jimenez (joelnavorjimenez@gmail.com)
// Combine segue manual
//  Created by MacBook on 22/12/22.
//

import UIKit
import Combine

class DetailEmpleadoViewController: UIViewController {
    //Creo a mi empleado Subject
    var empleadoSubject:  PassthroughSubject<Empleado, Never>?
    //creo a mi tipo empleado
    var empleadoSeleccionado: Empleado?

    
    @IBAction func cancelar(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    //Conexiones de los textfield al storyboard
    @IBOutlet weak var nombreTextField: UITextField!
    
    
    @IBOutlet weak var puestoTextField: UITextField!
    
    
    @IBOutlet weak var sueldoTextField: UITextField!
    //Funciòn que se ejecuta al cargarse la primer pantalla
    override func viewDidLoad() {
        super.viewDidLoad()
        //Le digo a mi pantalla que actualize los valores de mis textInput con los datos enviados desde mi tabla en la pantalla principal
        nombreTextField.text = "\(empleadoSeleccionado!.nombre)"
        puestoTextField.text = "\(empleadoSeleccionado!.puesto)"
        sueldoTextField.text = "\(empleadoSeleccionado!.sueldo)"
        }
    //Botòn enviar que actualizara y guardara los datos de mi arreglo para mostrarlos de forma actualizada en mi tabla al inicio de la aplicaciòn
    @IBAction func botonEnviar(_ sender: Any) {
        //indicamos que datos son los que pueden modificarse con los datos agregados en el textField
        let id: Int = empleadoSeleccionado!.id
        let nombre: String = nombreTextField.text!
        let puesto: String = puestoTextField.text!
        let sueldo: Double = Double(sueldoTextField.text!)!
        let antiguedad: Int = empleadoSeleccionado!.antiguedad
        //Creaciòn del empleado acutalizado con los datos nuevos
        let empleadoActualizado = Empleado(id: id, nombre: nombre, puesto: puesto, sueldo: sueldo, antiguedad: antiguedad)
              // empleadoSubject que enviara los datos de de mi empleado actualizado
              if let empleadoSubject = empleadoSubject {
                  empleadoSubject.send(empleadoActualizado)
              }
                //al presionar mi botòn regresa a mi pantalla anterior .pop
              dismiss(animated: true)
          }
    
    }



