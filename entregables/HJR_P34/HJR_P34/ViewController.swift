/*
 Heber Eduardo Jimenez Rodriguez
 
 Creado el 22-12-22
 
 Práctica 34 - Uso del Framework Combine
 */


// empleadosTableViewCell = nombre de la celda utilizable
// goToEmpleadosDetalles = nombre de mi segue


import UIKit
import Combine

// Estructura Empleados
struct Empleado {
    let id: Int
    let nombre: String
    let puesto: String
    let edad: Int
}

class ViewController: UIViewController {
    
    // Variable que almacena un empleado, poder saber que empleado seleccione y saber cual enviar a la siguiente pantalla.
    var empleadoSeleccionado: Empleado?
    
    @IBOutlet weak var empleadosTableView: UITableView!
    
    // Retiene un sujeto capaz de pasar objetos tipo String
    // que vamos enviar, tipo de error
    var empleadoSubject = PassthroughSubject<Empleado, Never>()
    
    // Variable para retener un suscriptor capaz de hacer algo con los objetos de tipo String
    var empleadoSubscribe: AnyCancellable?
    
    // Arreglo empleados, el cual sera el que se mostrara en la pantalla principal
    var empleados: [Empleado] = [Empleado(id: 1, nombre: "Heber", puesto: "Desarrollador", edad: 32),
                                 Empleado(id: 2, nombre: "Nathaly", puesto: "Pedagoga", edad: 30),
                                 Empleado(id: 3, nombre: "Jocelyn", puesto: "Abogada", edad: 31),
                                 Empleado(id: 4, nombre: "Emiliano", puesto: "Electricista", edad: 25),
                                 Empleado(id: 5, nombre: "Angela", puesto: "Secretari", edad: 28),
                                 Empleado(id: 6, nombre: "Aron", puesto: "Contador", edad: 32)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        empleadosTableView.delegate = self
        empleadosTableView.dataSource = self
        
        empleadoSubscribe = empleadoSubject.sink(receiveValue: {
            
            // Recibimos el empleado midificado
            empleadoRecibido in
            print(empleadoRecibido.id)
            print(empleadoRecibido.nombre)
            print(empleadoRecibido.edad)
            print(empleadoRecibido.puesto)
            
            // Recorremos todo el arreglo de empleados para identificar el empleado
            // modificado y reemplazarlo.
            for i in 0..<self.empleados.count {
                if empleadoRecibido.id == self.empleados[i].id {
                    // Ya que ubico el empleado modificado, lo reemplaza
                    self.empleados[i] = empleadoRecibido
                }
            }
            // Actualizamos la vista con el empleado modificado
            self.empleadosTableView.reloadData()
            
        })
    }
    
    // Funcion que envia el empleado seleccionado a la siguiente vista para
    // poder ver todos los detalles del empleado
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEmpleadosDetalles" {
            if let empleadosDetallesViewController = segue.destination as? EmpleadosDetallesViewController {
                empleadosDetallesViewController.empleadoSubject = self.empleadoSubject
                empleadosDetallesViewController.empleadoSeleccionado = self.empleadoSeleccionado
            }
        }
    }
}

// Extencion para implementar UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Define cuantas secciones hay en la tabla(en este caso 1)
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Define cuál es el título para la sección dada
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Empleados"
    }
    
    // Define cuantas filas tendra cada sección
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // El numero de filas que tendra nuestra sección es dependiendo el numero de elementos que tenga nuestro arreglo "empleados"
        return empleados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Recuperamos una celda desde tableView, pasandole su identificador "empleadosTableViewCell".
        let cell = tableView.dequeueReusableCell(withIdentifier: "empleadosTableViewCell")!
        // Configuramos que solo aparezca el nombre de los empleados
        cell.textLabel?.text = "\(empleados[indexPath.row].nombre)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        empleadoSeleccionado = empleados[indexPath.row]
        performSegue(withIdentifier: "goToEmpleadosDetalles", sender: nil)
        }
}

