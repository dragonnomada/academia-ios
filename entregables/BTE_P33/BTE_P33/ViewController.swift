//
//  ViewController.swift
//  BTE_P33
//
//  Created by MacBook Pro on 21/12/22.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    var persistentContainer: NSPersistentContainer?
 
    @IBOutlet weak var tableViewController: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableViewController.delegate = self
        tableViewController.dataSource = self
        
    }


    @IBAction func buttonAdd(_ sender: Any) {
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "main-registro-segue" {
            if let registroEmpleadoViewController = segue.destination as? RegistroEmpleadoViewController {
                
                registroEmpleadoViewController.persistentContainer = self.persistentContainer
                
                registroEmpleadoViewController.viewController = self
            }
        }
    }

}
// Implementamos el UITable en su datasourse y el delegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Creamos el contexto de presistentContainerr
        if let context = persistentContainer?.viewContext {
            // generamos la plantilla del fetch tipo Request
            let requestEmpleados =  Empleado.fetchRequest()
            
            if let empleados = try? context.fetch(requestEmpleados) {
                return empleados.count
            }
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Creamos una unica seccion
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Nombramos la unica seccion creada
        return "Empleados"
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // guardamos la celda reusable en una celda
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellViewController")!
        
        if let context = persistentContainer?.viewContext {
            // Traemos todos los empleados
            let requestEmpleados =  Empleado.fetchRequest()
            if let empleados = try? context.fetch(requestEmpleados) {
                
                // Configuramos la celda
                cell.textLabel?.text = "\(empleados[indexPath.row].id) \(empleados[indexPath.row].nombre!)"
                
                cell.detailTextLabel?.text = "\(empleados[indexPath.row].cargo!)"
            }
        }
        return cell
    }
    
    
}

