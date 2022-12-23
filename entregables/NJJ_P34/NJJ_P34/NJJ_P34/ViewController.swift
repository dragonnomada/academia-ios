//
//  ViewController.swift
//  NJJ_P34
// Joel Brayan Navor Jimenez (joelnavorjimenez@gmail.com)
//
//  Created by MacBook on 22/12/22.
//

import UIKit
import Combine //Importaciòn combine

class ViewController: UIViewController {
    //Intancia de mi empleadoSubject
    var empleadoSubject = PassthroughSubject<Empleado, Never>()
    //Instancia de mi empleadoSubscriber
    var empleadoSubscriber: AnyCancellable?
    //Instancia del empleado seleccionado del tipo empleado
    var empleadoSeleccionado: Empleado?
    //Creaciòn de arreglo de empleados
    var empleados : [Empleado] = [
        Empleado(id: 1, nombre: "Joel", puesto: "Desarrollador", sueldo: 33.20, antiguedad: 1),
        Empleado(id: 2, nombre: "Hernesto", puesto: "Recursos Humanos", sueldo: 330.20, antiguedad: 3)
    ]
    //Conexion a mi tabla
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Le indicamos que nuestro data source y nuestro delegate forman parte de nuuestra misma clase
        myTableView.delegate = self
        myTableView.dataSource = self
        //empleadoSubscriber va a recibir los datos de empleado subject y guardara en una variable (empleadoRecibido) para despues asignarle los valores a empleadoSubscriber
        empleadoSubscriber = empleadoSubject.sink(receiveValue: { empleadoRecibido in
            //vemos que datos recibimos
            print(empleadoRecibido)
            //Recorremos a empleados para emparejar los datos recibidos con el indice de mi arreglo de empleados y asignamos los nuevos valores
            for i in 0..<self.empleados.count {
                if empleadoRecibido.id == self.empleados[i].id {
                    self.empleados[i] = empleadoRecibido
                }
            }
            //Recargamos la tabla con los datos actualizados
            self.myTableView.reloadData()
                    
                })
        
    }
    //Preparaciòn del segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mySegue" {
            if let detailEmpleado = segue.destination as? DetailEmpleadoViewController {
                detailEmpleado.empleadoSubject = self.empleadoSubject
                detailEmpleado.empleadoSeleccionado = self.empleadoSeleccionado
                }
            }
            
        }
        
    }
    
//Estructura empleado con los datos del empleado
struct Empleado {
    let id: Int
    let nombre: String
    let puesto: String
    let sueldo: Double
    let antiguedad: Int
}
//Repositorio empleado para la creaciòn del singletron main
class EmpleadosRepository {
    static let main = EmpleadosRepository()
    
   
}
//DataSource y Delegate de mi tabla
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //Configuracion del numero de filas por secciòn
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return empleados.count
    }
    //Configuracion de los datos en celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellD")!
            
        cell.textLabel?.text = "\(empleados[indexPath.row].nombre)"
        cell.detailTextLabel?.text = "\(empleados[indexPath.row].puesto)"
            return cell
        }
        //Configuraciòn del nombre de mi secciòn
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Empleados"
        }
        //Configuraciòn del numero de seccionnes
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        //Por medio de didSelectRow le indicamos que a que empleado le queremos modificar los datos
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            //indicamos el indice del empleado en la celda seleccionada
            empleadoSeleccionado = empleados[indexPath.row]
            //Ejecutamos el segue para pasar a la pantalla de detalles del empleado
            performSegue(withIdentifier: "mySegue", sender: nil)
        }
        
    }
    
    
    

