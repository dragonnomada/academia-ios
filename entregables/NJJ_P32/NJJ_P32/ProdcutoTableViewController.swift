//
//  ViewController.swift
//  NJJ_P32
//
//  Created by MacBook on 20/12/22.
//

import UIKit

class ProdcutoTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet var myTableView: UITableView!

}
extension ProdcutoTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductosRepository.main.productos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Celda")!
            let producto = ProductosRepository.main.productos[indexPath.row]
            cell.textLabel?.text = producto.nombre
            cell.detailTextLabel?.text = "$\(producto.precio)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return "Productos"
       }
    func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }
}
class ProductosRepository {
    static let main  = ProductosRepository()
    
    var productos : [(id: Int, nombre: String, precio: Double, existencias: Int)] = [(1, "Suavitel", 20.20, 25), (2, "Pino", 21.25, 17),(3, "Roma", 17.50, 13   )]
}
