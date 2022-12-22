/*
 Heber Eduardo Jimenez Rodriguez
 
 Creado el 21-12-22
 
 Práctica 33 - Uso de Core Data y persistencia
 */

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // Definir la variable de persistencia
    var persistentContainer: NSPersistentContainer?
    
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
    
    // Funcion que configura lo que le enviaremos a la siguiente vista
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "irDetallesEmpleado" {
            if let registroEmpleadoViewController = segue.destination as? RegistroEmpleadoViewController {
                registroEmpleadoViewController.persistentContainer = self.persistentContainer
                registroEmpleadoViewController.viewController = self
            }
        }
    }
}


// Extencion de ViewController donde indicamos la configuraión de como se vera la vista e implementamos el delgate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Indica el numero de secciones que requerimos, en este caso 1
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
    // Funcion para inidicar el titulo que queremos en la sección, en este caso "Empleados"
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Empleados"
        }
    
    // Funcion donde creamos el context de persistentContainer
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
        
        // Celda reusable 
        let cell = tableView.dequeueReusableCell(withIdentifier: "empleadosTableViewCell")!
        
        if let context = persistentContainer?.viewContext {
            // Cargar los empleados.
            let requestEmpleados = Empleado.fetchRequest()
            if let empleados = try? context.fetch(requestEmpleados) {
                let empleado = empleados[indexPath.row]
                // Indicamos que informacion de los empleados queremos que se muestre en la celda
                cell.textLabel?.text = empleado.nombre
                cell.detailTextLabel?.text = "Edad:\(empleado.edad), Telefono: \(empleado.telefono)"
            }
        }
        return cell
    }
}

