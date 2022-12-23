//
//  ViewController.swift
//  BTA_P34
//
//  Created by MacBook Pro on 22/12/22.
//

import UIKit

import Combine

// 1 Definimos las propiedades del Empleado

struct Empleado {
    let id: Int
    var nombre: String
    var edad: Int
    var puesto: String
}


class ViewController: UIViewController {
    
    // Creamos El sujeto encargador de mandar y recibir entre vista
    
    var empleadoSubject = PassthroughSubject<Empleado, Never>()

    // Definimos el suscriptor
    
    var empleadoSuscriber: AnyCancellable?
    
    
    var empleadoSeleccionado: Empleado?
    
//    var empleados: [Empleado]?
    
    var empleados: [Empleado]? = [
        Empleado(id: 10, nombre: "Eduardo Batista", edad: 27, puesto: "Desarrollador"),
        Empleado(id: 50, nombre: "Javier Lopez", edad: 54, puesto: "Gerente"),
        Empleado(id: 45, nombre: "Veronica Trujillo", edad: 56, puesto: "Vendedora"),
        Empleado(id: 88, nombre: "Rocio Cazares", edad: 40, puesto: "Cuidadora"),
        Empleado(id: 99, nombre: "Josue Huerta", edad: 32, puesto: "Soldado")
    ]

    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        
        // Cuando el sujeto de la segunda vista llame a su metodo .send
        // .sink implementara la actualizacion de empleado y recargará la vista.
        // con el parametro empleado que viene de la segunda vista
        
        empleadoSuscriber = empleadoSubject.sink(receiveValue: { empleado in
            self.actulizarEmpleado(empleado: empleado)
            self.myTableView.reloadData()
        })
    }
    
    
    // Praparamos el segue para que cargue en la segunda vista el sujeto y el empleado
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Editar-Segue" {
            if let empleadoSelectoViewController = segue.destination as? EmpleadoSelectoViewController {
                empleadoSelectoViewController.empleadoSubject = self.empleadoSubject
                empleadoSelectoViewController.empleadoSeleccionado = self.empleadoSeleccionado
            }
            
        }
    }
   
    // Definimos de forma manual la funcion que actualizará al empleado, con el parametro
    // Id
    
    func actulizarEmpleado(empleado: Empleado){
        if self.empleados != nil {
            for i  in 0..<empleados!.count {
                if self.empleados![i].id == empleado.id {
                    empleados![i].nombre = empleado.nombre
                    empleados![i].edad = empleado.edad
                    empleados![i].puesto = empleado.puesto
                }
            }
        } else { print("Error Para actualizar los datos")}
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        if empleados?.count != nil {
//            return empleados!.count
//        }else {
//            return 0
//        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if empleados != nil {
//            return "Empleado \(section + 1)"
//        }else {
//            return "Data Empty"
//        }
        
        return "Empleados"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return empleados?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellEmpleado")!
        
        if (empleados?[indexPath.row]) != nil {

            cell.textLabel?.text = "\(empleados![indexPath.row].id) \(empleados![indexPath.row].nombre) - \(empleados![indexPath.row].edad)"

            cell.detailTextLabel?.text = "\(empleados![indexPath.row].puesto)"
        }
        
        return cell
    }
    
    
    // Disparamos el segue cuando seleccione un row de la tableView, y guardamos el empleado seleccionado que posteriormente se enviara por el prepare
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        empleadoSeleccionado = empleados![indexPath.row]
        performSegue(withIdentifier: "Editar-Segue", sender: nil)
        
    }
    
    
}

