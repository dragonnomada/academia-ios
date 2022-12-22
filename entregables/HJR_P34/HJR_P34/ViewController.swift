/*
 Heber Eduardo Jimenez Rodriguez
 
 Creado el 22-12-22
 
 Práctica 34 - Uso del Framework Combine
 */


// empleadosTableViewCell = nombre de la celda utilizable
// goToEmpleadosDetalles = nombre de mi segue


import UIKit
import Combine

class ViewController: UIViewController {
    
    var empleado: Empleado?
    
    @IBOutlet weak var empleadosTableView: UITableView!
    //[1] Retiene un sujeto capaz de pasar objetos tipo String
                              // que vamos enviar, tipo de error
    var empleadoSubject = PassthroughSubject<[Empleado], Never>()
    
    //[2] Variable para retener un suscriptor capaz de hacer algo con los objetos de tipo String
    var empleadoSubscribe: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //[3]
        empleadoSubscribe = empleadoSubject.sink {
            empleado in
            // self.frutaLabel.text = fruta
        }
        
        empleadosTableView.delegate = self
        empleadosTableView.dataSource = self
    }
}

// Repositorio ProductosRepository
class EmpleadosRepository {
    // Singleton
    static let main = EmpleadosRepository()
    
    var empleados: [Empleado] = [Empleado(id: 1, nombre: "Heber", puesto: "Desarrollador", edad: 32),
                                 Empleado(id: 2, nombre: "Nathaly", puesto: "Pedagoga", edad: 30),
                                 Empleado(id: 3, nombre: "Jocelyn", puesto: "Abogada", edad: 31),
                                 Empleado(id: 4, nombre: "Emiliano", puesto: "Electricista", edad: 25),
                                 Empleado(id: 5, nombre: "Angela", puesto: "Secretari", edad: 28),
                                 Empleado(id: 6, nombre: "Aron", puesto: "Contador", edad: 32)]
    
}

// Estructura Empleados
struct Empleado {
    let id: Int
    let nombre: String
    let puesto: String
    let edad: Int
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
        return EmpleadosRepository.main.empleados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Recuperamos una celda desde tableView, pasandole su identificador "empleadosTableViewCell".
        let cell = tableView.dequeueReusableCell(withIdentifier: "empleadosTableViewCell")!
        // Configuramos que solo aparezca el nombre de los empleados
        cell.textLabel?.text = EmpleadosRepository.main.empleados[indexPath.row].nombre
        //cell.detailTextLabel?.text = EmpleadosRepository.main.empleados[indexPath.row].puesto
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detallesProductoSegue", sender: EmpleadosRepository.main.empleados[indexPath.row])
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "goToEmpleadosDetalles" {
                guard let empleadosDetallesViewController = segue.destination as? EmpleadosDetallesViewController else { return }
                guard let empleadoSeleccionado = sender as? Empleado else { return }
                empleadosDetallesViewController.empleado = empleadoSeleccionado
            }
        }
}

