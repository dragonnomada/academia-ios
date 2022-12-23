//
//  ViewController.swift
//  NJJ_P34
// Joel Brayan Navor Jimenez (joelnavorjimenez@gmail.com)
//
//  Created by MacBook on 22/12/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    var empleadoSubject = PassthroughSubject<String, Never>()
    
    var empleadoSeleccionado: Empleado? = nil
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mySegue" {
            if let detailEmpleado = segue.destination as? DetailEmpleadoViewController {
                if let empleadoSeleccionado = sender as? Empleado {
                    detailEmpleado.empleado = empleadoSeleccionado
                }
            }
            
        }
        
    }
    
    
}

struct Empleado {
    let id: Int
    let nombre: String
    let puesto: String
    let sueldo: Double
    let antiguedad: Int
}

class EmpleadosRepository {
    static let main = EmpleadosRepository()
    
    var empleados : [Empleado] = [Empleado(id: 1, nombre: "Joel", puesto: "Desarrollador", sueldo: 33.20, antiguedad: 1)]
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EmpleadosRepository.main.empleados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let empleado = EmpleadosRepository.main.empleados[indexPath.row]
        cell.textLabel?.text = empleado.nombre
        cell.detailTextLabel?.text = empleado.puesto
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Empleados"
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let empleado = EmpleadosRepository.main.empleados[indexPath.row]
        empleadoSeleccionado = empleado
        performSegue(withIdentifier: "mySegue", sender: nil)
        }
        
    }
    


