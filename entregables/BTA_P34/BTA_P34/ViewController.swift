//
//  ViewController.swift
//  BTA_P34
//
//  Created by MacBook Pro on 22/12/22.
//

import UIKit

import Combine

struct Empleado {
    let id: Int
    var nombre: String
    var edad: Int
    var puesto: String
}


class ViewController: UIViewController {
    
    var empleadoSubject = PassthroughSubject<Empleado, Never>()

    var empleadoSuscriber: AnyCancellable?
    
    
    var empleadoSeleccionado: Empleado?
    
//    var empleados: [Empleado]?
    
    var empleados: [Empleado]? = [
        Empleado(id: 0, nombre: "Eduardo", edad: 27, puesto: "Desarrollador"),
        Empleado(id: 1, nombre: "Javier", edad: 54, puesto: "Gerente")
    ]

    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        empleadoSuscriber = empleadoSubject.sink(receiveValue: { empleado in
            print("Nuevos Datos Actualizados")
            print(empleado.id)
            print(empleado.nombre)
            print(empleado.edad)
            print(empleado.puesto)
            
        })
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Editar-Segue" {
            if let empleadoSelectoViewController = segue.destination as? EmpleadoSelectoViewController {
                empleadoSelectoViewController.empleadoSubject = self.empleadoSubject
                empleadoSelectoViewController.empleadoSeleccionado = self.empleadoSeleccionado
            }
            
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Empleados"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return empleados?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellEmpleado")!
        
        if (empleados?[indexPath.row]) != nil {
            
            cell.textLabel?.text = "ID: \(empleados![indexPath.row].id) Nombre: \(empleados![indexPath.row].nombre)"
            
            cell.detailTextLabel?.text = "Edad: \(empleados![indexPath.row].edad) Puesto:\(empleados![indexPath.row].puesto)"
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        empleadoSeleccionado = empleados![indexPath.row]
        performSegue(withIdentifier: "Editar-Segue", sender: nil)
        
    }
    
    
}

