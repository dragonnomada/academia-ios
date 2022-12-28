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

    var prospectosModel: NSPersistentContainer?
    
    var prospectos: [Prospecto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarProspectos()
        // Do any additional setup after loading the view.
    }
    func cargarProspectos() {
        if let context = prospectosModel?.viewContext {
            
            let requestProspectos = Prospecto.fetchRequest()
            
            if let prospectos = try? context.fetch(requestProspectos) {
                self.prospectos = prospectos
//                for _ in prospectos {
//
//                }
            }
            
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
            cell.nombreLabel.text = "\(prospecto.nombre) \(prospecto.apellido_paterno) \(prospecto.apellido_materno)"
            cell.estadoLabel.text = prospecto.estado
            cell.fechaInicioLabel.text = prospecto.fechaInicio
            cell.fechaActualizado.text = prospecto.fechaActualizado
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
    }
    
}

