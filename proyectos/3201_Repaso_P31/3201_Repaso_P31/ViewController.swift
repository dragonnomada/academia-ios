//
//  ViewController.swift
//  3201_Repaso_P31
//
//  Created by User on 20/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myTableView.dataSource = self
        myTableView.delegate = self
    }
    
}

/*var lista1: [String] = ["Pastor Alemán", "French Poddle", "Chihuahueño"]
var lista2: [(futbolista: String, valoracion: Int)] = [
    ("Mbappe", 95), ("Messi", 100), ("Chicharito", 60),
    ("Memo Ochoa", 89)
]*/

class RazasPerrosRepository {
    static let main = RazasPerrosRepository()
    
    var razas: [String] = ["Pastor Alemán", "French Poddle", "Chihuahueño"]
}

class ValoracionesFutbolistasRepository {
    static let main = ValoracionesFutbolistasRepository()
    
    var valoraciones: [(futbolista: String, valoracion: Int)] = [
        ("Mbappe", 95), ("Messi", 100), ("Chicharito", 60),
        ("Memo Ochoa", 89)
    ]
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Razas de Perros"
        case 1:
            return "Valoración de Futbolistas"
        default:
            return "Desconocido"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return RazasPerrosRepository.main.razas.count
        case 1:
            return ValoracionesFutbolistasRepository.main.valoraciones.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /// 1. Recuperamos una celda reusable identificada en el `storyboard`
        ///      a través del `tableView` pasado en la función
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell")!
        
        /// 2. Configurar la celda con su representación
        switch indexPath.section {
        case 0: // Razas de perros
            let raza = RazasPerrosRepository.main.razas[indexPath.row]
            cell.textLabel?.text = raza
        case 1: // Jugadores de futbol
            let (jugador, valoracion) = ValoracionesFutbolistasRepository.main.valoraciones[indexPath.row]
            cell.textLabel?.text = jugador
            cell.detailTextLabel?.text = "\(valoracion)/100"
        default:
            print("Error, no hay más secciones")
            
        }
        
        /// 3. Devolvemos la celda ya configurada
        return cell
    }
    
}

