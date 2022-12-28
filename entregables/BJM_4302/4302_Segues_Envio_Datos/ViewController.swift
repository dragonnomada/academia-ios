//
//  ViewController.swift
//  4302_Segues_Envio_Datos
//
//  Created by User on 28/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frutasTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frutasTableView.dataSource = self
        frutasTableView.delegate = self
        
    }


}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Frutas"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FrutasRepository.shared.getFrutasCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")!
        
        if let fruta = FrutasRepository.shared.getFruta(index: indexPath.row) {
            var config = cell.defaultContentConfiguration()
            config.text = fruta.nombre
            config.secondaryText = "\(fruta.peso) kg"
            
            cell.contentConfiguration = config
        }
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("se ha selecionado la sección \(indexPath.section) en la fila \(indexPath.row)")
        
        if let fruta = FrutasRepository.shared.getFruta(index: indexPath.row) {
            print(fruta)
            
            /// **PASO 1** - Realizamos el perform Segue enviando con el ´sender´ fruta
            self.performSegue(withIdentifier: "AtoB", sender: fruta)
        }
    }
}

extension ViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /// **PASO 3** - Configuramos la fruta de la **Pantalla B** desde esta pantalla
        
        /// 1. Recuperamos la **Pantalla B**
        if let pantallaB = segue.destination as? BViewController {
            /// 2. Reconvertimos el ´sender´como ´Fruta´(lo que se envío en el ´performSegue´)
            if let fruta = sender as? Fruta {
                ///3. Ajustar o configurar la fruta opcional de la **Pantalla B**
                pantallaB.fruta = fruta
            }
        }
    }
}
