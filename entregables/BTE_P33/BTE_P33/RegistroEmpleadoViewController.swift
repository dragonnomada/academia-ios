//
//  RegistroEmpleadoViewController.swift
//  BTE_P33
//
//  Created by MacBook Pro on 21/12/22.
//

import UIKit
import CoreData

class RegistroEmpleadoViewController: UIViewController {

    weak var persistentContainer: NSPersistentContainer?
    
    weak var viewController: ViewController?

    
    @IBOutlet weak var empleadoRegistroVC: UITextField!
    
    
    @IBOutlet weak var nombreRegistroVC: UITextField!
    
    
    @IBOutlet weak var cargoRegistroVC: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancelarRegistroVC(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    // Creamos el contexto de persistentContainer Para mostrarlos en consola
    // Confirmando y actualizando en consola la base de datos
    func cargarEmpleados(){
        
        // Si se puede crear el contexto creamos un fetch
        if let context = persistentContainer?.viewContext {
            
            // Creamos una  plantilla para el fetch tipo Request en Empleado
            
            let requestEmpleados = Empleado.fetchRequest()
            
            // Tratamos que contexto genere un fetch apatir de la pantilla
            // Si lo cumple nos traera un arreglo timpo Empleados
            if let empleados = try? context.fetch(requestEmpleados) {
                
                // Imprimimos en consola el arreglo Empleados en consola
                for empleado in empleados {
                    print("Producto:[\(empleado.id)] \(empleado.nombre!)  \(empleado.cargo!)")
                }
                // Formato divisor
                print("---------------------------------")
                
            }
        }
    }
    
    
    @IBAction func confirmarRegistroVC(_ sender: Any) {
        // Creamos el contexto a partir del persistentContainer
        if let context = persistentContainer?.viewContext {
            
            // creamos empleado a partir del Empleado
            let empleado = Empleado(context: context)
            
            // Configura los valores del nuevo empleado antes de guardarlos
            
            empleado.id = Int32(empleadoRegistroVC.text ?? "0") ?? 0
            empleado.nombre = nombreRegistroVC.text
            empleado.cargo = cargoRegistroVC.text
            
            do {
                // Trata de guardar todos los valorese del empleado y resetea los
                // valores de los textfield
                
                try context.save()
                print("Producto Guardado")
                empleadoRegistroVC.text = ""
                nombreRegistroVC.text = ""
                cargoRegistroVC.text = ""
                empleadoRegistroVC.becomeFirstResponder()
                
                // Recargamos la tableViewController
                viewController?.tableViewController.reloadData()
                
                // Recargamos la lista de empleados que se muestra en consola
                cargarEmpleados()
                
                
                self.dismiss(animated: true)
            } catch {
                
                context.rollback()
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
