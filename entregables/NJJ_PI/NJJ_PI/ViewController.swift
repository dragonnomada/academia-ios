//
//  ViewController.swift
//  NJJ_PI
//  Joel Brayan Navor Jimenez (joelnavorjimenez@gmail.com)
//  Trabajo Creado el 27/12/22.
//  Proyecto Individual ReclutaApp
//  Created by MacBook on 27/12/22.
//

import UIKit
import CoreData /// Importación CoreData

/// Extensión a Date para un formato mas corto y en español
extension Date {
    /// Nombre de nuestra función encargada de darle el formato a nuestras fechas.
    func toString() -> String {
        let formato = DateFormatter()
        
        formato.locale = Locale(identifier: "es_MX")
        
        formato.dateStyle = .short

        formato.setLocalizedDateFormatFromTemplate("YYYY/MMM/dd")
        
        return formato.string(from: self)
    }
    
}

class ViewController: UIViewController {
    
    /// Conexión a la tabla de la vista principal con el nombre ("myTableView")
    @IBOutlet weak var myTableView: UITableView!
    /// Instancia de la variable para la conexion a los datos persistentes.
    var prospectoPersistentContainer: NSPersistentContainer?
    /// Creación de la variable prospectos de tipo array de prospectos incializada en vacio.
    var prospectos: [Prospecto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarProspectos() /// Carga de los prospectos
        /// Asignamos la localizacion de nuestro delegate y datasource de la tabla        myTableView.delegate = self
        myTableView.dataSource = self
    }
    /// Funcion encargada de la creación del contexto, hacer un fetchRequest y recargar los datos de la tabla con lo obtenido del fetchRequest.
    func cargarProspectos() {
        /// Creación de la variable para asignarle el contexto del contenedor de datos persistentes.
        if let context = prospectoPersistentContainer?.viewContext {
            /// Petición para traer los datos de la entidad Prospecto.
            let requestProspectos = Prospecto.fetchRequest()
            /// Creación de la constante prospectos para requisar lo obtenido por requestProspectos.
            if let prospectos = try? context.fetch(requestProspectos) {
//                for prospecto in prospectos {
//                    context.delete(prospecto)
//                }
//                do {
//                    try context.save()
//                    print("Borrados")
//                } catch {
//                    context.rollback()
//                    print("No se pudieron borrar. Error: \(error)")
//                }
                /// Asingnamos los prospectos
                self.prospectos = prospectos
                /// Impresion para ver que si haya prospectos
                print(prospectos)
                /// Recargamos los datos de myTableView
                self.myTableView.reloadData()
            }
            
        }
    }

}

/// Extensión a viewController para cargar los datos de los prospectos siempre que se entre a la pantalla.
extension ViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.cargarProspectos()
    }
    
}

extension ViewController {
    /// Creación del perform segue para las pantallas Agregar nuevo prospecto y Perfil
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /// Switch para los diferentes segues segun su identificador.
        switch segue.identifier {
        case "AddProspectoSegue":
            /// Asignacion del destino para nuestro prepare hacia ReclutarViewController pasandole el modelo y nuestro persistentContainer
            if let reclutarViewController = segue.destination as? ReclutarViewController {
                reclutarViewController.prospectosModel = self.prospectoPersistentContainer
            }
        case "PerfilSegue":
            /// Asignación del destino hacia nuestro PerfilViewController
            if let perfilViewController = segue.destination as? PerfilViewController {
                /// Reconvertimos el `sender`como  `Prospecto` (lo envia el performSegue)
                if let prospecto = sender as? Prospecto {
                    /// Ajuste o configuraciòn del prospecto opccional para la pantalla **PerfilViewController**
                    perfilViewController.prospecto = prospecto
                    /// Asignación del contenedor a perfilViewController
                    perfilViewController.prospectoPersistentContainer = prospectoPersistentContainer
                }
            }
            
        default:
            print("Identificador de segue no válido")
        }
            
    }
    
}
/// Extensión para el contenido de myTableView
extension ViewController: UITableViewDataSource {
    /// Numero de filas por sección, en este caso es igual al numero de prospectos en el contenedor de los datos persistentes.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prospectos.count
    }
    /// Asignación del contenido de cada celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /// Contrucción de la celda con el identificador: EmpleadoCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmpleadoCell")!
        /// Le decimos que la celda pertenece a una clase Custom
        if let cell = cell as? CustomTableViewCell {
            /// Asignamos los datos para cada celda en el index de cada fila
            let prospecto = self.prospectos[indexPath.row]
            /// Asignamos los valores para cada label de nuestra celda.
            if let nombre = prospecto.nombre,
               let apellidoP = prospecto.apellidoPaterno,
               let apellidoM = prospecto.apellidoMaterno {
                
                cell.nombreLabel.text = "\(apellidoP) \(apellidoM), \(nombre)"
                
            }
            /// El estado del prospecto
            cell.estadoLabel.text = prospecto.estado
            /// La fecha de registro del prospecto
            if let fechaInicio = prospecto.fechaInicio {
                cell.fechaInicioLabel.text = fechaInicio.toString()
            }
            /// La fecha en la que le modifico algun valor al prospecto
            if let fechaActualizado = prospecto.fechaActualizado {
                cell.fechaActualizadoLabel.text = fechaActualizado.toString()
            }
            

        }
        /// Retornamos la celda
        return cell
    }
    /// El titulo para la sección "Prospectos"
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Prospectos"
    }
    /// El numero de secciones, solo 1 para prospectos
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
/// Extension a view Controller para el delegate
extension ViewController: UITableViewDelegate {
    /// Función didSelect para que al momento de presionar sobre la celda de algun prospecto este nos redireccione a su perfil.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /// Recuperamos los datos del prospecto dados por el indice de la celda
        let prospecto = self.prospectos[indexPath.row]
        /// PerformSegue con el identificador perfil y le mandamos el prospecto recuperado.
        performSegue(withIdentifier: "PerfilSegue", sender: prospecto)
    }
    
}

