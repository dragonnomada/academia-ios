//
//  RegistroEmpleadoViewController.swift
//  NJJ_P33
// Uso de segues, persistentcontainer
// Joel Brayan Navor Jimenez (joelnavorjimenez@gmail.com)
// Practica p31
// Creado el 21 de Diciembre de 2022
//
//

import UIKit
import CoreData //Importsciòn de core data


class RegistroEmpleadoViewController: UIViewController {
    
    //asiganamos nuestro persistentContainer
    weak var persistentContainer: NSPersistentContainer?
    //le decimos a ViewController que esperamos datos y mandaremos datos
    weak var viewController: ViewController?
    //Asignamos nuestros TextField del storyboard
    @IBOutlet weak var nombreLabel: UITextField!
    @IBOutlet weak var edadLabel: UITextField!
    @IBOutlet weak var puestoLabel: UITextField!
    @IBOutlet weak var salarioLabel: UITextField!
    //Acciones para el botòn cancelar
    @IBAction func cancelar(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //Cargamos los empleados del persistentContainer
    func cargarProductos() {
        if let context = persistentContainer?.viewContext {
            //lanzamos una peticion a persistent container para recibir los datos del empleado
            let requestEmpleados = Empleado.fetchRequest()
            //intentamos recibir los empleados obtenidos por el fetch
            if let empleados = try?
                //Imprimimos los datos por consola
                context.fetch(requestEmpleados) {
                for empleado in empleados {
                    print("Empleado: [\(empleado.id)] \(empleado.nombre!) $\(empleado.salario) \(empleado.edad)")
                }
                print("---------------------")
            }
        }
    }
    //Boton agregar con la accion de guardar los datos ingresados en los input text y mandarlos (sender)
    @IBAction func agregar(_ sender: Any) {
        // le decimos que nuestro context va a ser igual al contexto de persistentContainer y nos preparamos para recibir los datos de los empleados
        if let context = persistentContainer?.viewContext {
            //asinamos Los campos de empleado a nuestra constante empleado con el contexto de empleados
            let empleado = Empleado(context: context)
            //le decimos que la id de los empleados sera igual a un numero random entre 1 y un millon
            empleado.id = Int32.random(in: 1_000...1_000_000)
            //Le asignamos el nombre puesto en nuestro textInput
            empleado.nombre = nombreLabel.text
            //asignamos al contexto el numero de nuestro textfiel y si no le agregamos un nulo
            empleado.edad = Int32(edadLabel.text ?? "") ?? 0
            //asignamos el puesto colocado en nuestro textField
            empleado.puesto = puestoLabel.text
            //asignamos el salario colocado en nuestro textField
            empleado.salario = Double(salarioLabel.text ?? "") ?? 0.0
            do {
                //guardamos valores por defecto al no haberles asignado
                try context.save()
                print("Empleado Guardado")
                nombreLabel.text = ""
                edadLabel.text = ""
                puestoLabel.text = ""
                salarioLabel.becomeFirstResponder()
                cargarProductos()
                viewController?.myTableView.reloadData()
                dismiss(animated: true)
            }
            catch {
                context.rollback()
                print("No se puede guardar el producto")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
