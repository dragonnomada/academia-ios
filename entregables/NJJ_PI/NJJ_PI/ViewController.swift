//
//  ViewController.swift
//  NJJ_PI
//
//  Created by MacBook on 27/12/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var prospectoPersistentContainer: NSPersistentContainer?
    
    var prospectos: [Prospecto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarProspectos()
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    func cargarProspectos() {
        if let context = prospectoPersistentContainer?.viewContext {
            
            let requestProspectos = Prospecto.fetchRequest()
            
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
                self.prospectos = prospectos
                print(prospectos)
                self.myTableView.reloadData()
            }
            
        }
    }

}

extension ViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.cargarProspectos()
    }
    
}

extension ViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "AddProspectoSegue":
            if let reclutarViewController = segue.destination as? ReclutarViewController {
                reclutarViewController.prospectosModel = self.prospectoPersistentContainer
            }
        case "PerfilSegue":
            if let perfilViewController = segue.destination as? PerfilViewController {
                ///Reconvertimos el `sender`como  `Prospecto` (lo envia el performSegue)
                if let prospecto = sender as? Prospecto {
                    ///Ajuste o configuraciòn de la fruta opccional para la pantalla **PerfilViewController**
                    perfilViewController.prospecto = prospecto
                }
            }
            
        default:
            print("Identificador de segue no válido")
        }
            
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prospectos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmpleadoCell")!
        
        if let cell = cell as? CustomTableViewCell {
            
            let prospecto = self.prospectos[indexPath.row]
            
            if let nombre = prospecto.nombre,
               let apellidoP = prospecto.apellidoPaterno,
               let apellidoM = prospecto.apellidoMaterno {
                
                cell.nombreLabel.text = "\(apellidoP) \(apellidoM), \(nombre)"
                
            }
            
            cell.estadoLabel.text = prospecto.estado
            
            cell.fechaInicioLabel.text = "\(prospecto.fechaInicio ?? Date.now)"
    
            cell.fechaActualizadoLabel.text = "\( prospecto.fechaActualizado)"

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Prospectos"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Presionado")
        
        // TODO: Recupera el prospecto en el índice indexPath.row
        let prospecto = self.prospectos[indexPath.row]
        
        performSegue(withIdentifier: "PerfilSegue", sender: prospecto)
    }
    
}

