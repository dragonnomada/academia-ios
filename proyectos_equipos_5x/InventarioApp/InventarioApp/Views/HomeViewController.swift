//
//  HomeViewController.swift
//  InventarioApp
//
//  Created by MacBook  on 05/01/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var productTableView: UITableView!
    
    var productos: [ProductoEntity] = []
    var transacciones: [TransaccionEntity] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        productTableView.dataSource = self
        productTableView.delegate = self
        productTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //
    }
    
    @IBAction func addProductos(_ sender: UIButton){
        performSegue(withIdentifier: "Home-Add-Segue", sender: self)
    }

}

extension HomeViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transacciones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")!
//        let transaccion = self.transacciones[indexPath.row]
//        var confing = cell.defaultContentConfiguration()
//
////        if let entrada = transaccion.entrada{
//            confing.text = "\(transaccion.entrada ? "▲" : "▼") \(entrada)"
//        }
//        if
       
        return cell
    }
}

extension HomeViewController: UITableViewDelegate{
    // Navegar a la vista de detalles cuando una fila es selecionada
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "", sender: nil)
    }
}
