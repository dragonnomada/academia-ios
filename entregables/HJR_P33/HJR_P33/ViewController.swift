//
//  ViewController.swift
//  HJR_P33
//
//  Created by MacBook on 21/12/22.
//

// empleadosTableViewCell -> tableViewCell

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // Definir la variable para que nos ajuste
    var persistentContainer: NSPersistentContainer?
    
    
    // Funcion que configura lo que le enviaremos a la siguiente vista
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "irDetallesEmpleado" {
            if let registroEmpleadoViewController = segue.destination as? RegistroEmpleadoViewController {
                registroEmpleadoViewController.persistentContainer = self.persistentContainer
                registroEmpleadoViewController.viewController = self
            }
        }
    }
    
    
    @IBOutlet weak var empleadosTableView: UITableView!
    
    var registrarEmpleado: Empleado? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Asignamos quien sera el datasource y quien el delegado
        empleadosTableView.delegate = self
        empleadosTableView.dataSource = self
        empleadosTableView.reloadData()
    }
    
    // Funcion que manda el segue
    @IBAction func agregarEmpleadoAction(_ sender: Any) {
        print("Hola")
        performSegue(withIdentifier: "irDetallesEmpleado", sender: registrarEmpleado)
    }
    
}


// Extencion de ViewController donde indicamos la configuraión de como se vera la vista
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Indica el numero de elemntos que requerimos
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
    // Funcion para inidicar el titulo que queremos en la sección
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Empleados"
        }
    
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Obtener numero de empleados")
        if let context = persistentContainer?.viewContext {
            let requestEmpleados = Empleado.fetchRequest()
            if let empleados = try? context.fetch(requestEmpleados) {
                print("Hay \(empleados.count) empleados")
                return empleados.count
            }
        }
        return 0
    }
    
    // Funcion que carga los empleados en la vista
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "empleadosTableViewCell")!
        
        if let context = persistentContainer?.viewContext {
            let requestEmpleados = Empleado.fetchRequest()
            if let empleados = try? context.fetch(requestEmpleados) {
                let empleado = empleados[indexPath.row]
                cell.textLabel?.text = empleado.nombre
                cell.detailTextLabel?.text = "Edad:\(empleado.edad), Telefono: \(empleado.telefono)"
            }
        }
        return cell
    }
}

