//
//  DetailsProductViewController.swift
//  InventarioApp
//
//  Created by MacBook  on 05/01/23.
//

import UIKit

class DetailsProductViewController: UIViewController {
    
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameView: UILabel!
    @IBOutlet weak var productDescripcionView: UILabel!
    @IBOutlet weak var productIdView: UILabel!
    @IBOutlet weak var productExistenciasView: UILabel!
    @IBOutlet var transaccionesTableView: UITableView!
    
    
    var transacciones: [TransaccionEntity] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        transaccionesTableView.dataSource = self
        //tableView.delegate = self
        
    }
    
    @IBAction func agregarTransaccion(_ sender: Any) {
        //
    }

}

extension DetailsProductViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transacciones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "")!
        let transaccion = self.transacciones[indexPath.row]
        var confing = cell.defaultContentConfiguration()
        
//        if let entrada = transaccion.entrada{
//            confing.text = "\(transaccion.entrada ? "▲" : "▼") \(entrada)"
//        }
//        if
        
        return cell
    }
}

//extension DetailsProductViewController: UITableViewDelegate{
//    // Navegar a la vista de detalles cuando una fila es selecionada
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "", sender: nil)
//    }
//}

