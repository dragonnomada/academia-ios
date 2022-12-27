//
//  ViewController.swift
//  E33301_MVC
//
//  Created by MacBook Pro on 23/12/22.
//

import UIKit

struct Producto {
    
    let id: Int
    let nombre: String
    let precio: Double
    let existencias: Int
    var hayExistencias: Bool { get { existencias > 0 } }
    
}

class ProductoModel {
    
    static let shared = ProductoModel()
    
    let productos: [Producto] = [
        Producto(id: 1, nombre: "Coca-Cola", precio: 12.5, existencias: 20),
        Producto(id: 2, nombre: "Gansito", precio: 23.12, existencias: 11),
        Producto(id: 3, nombre: "Chocorrol", precio: 15.99, existencias: 16)
    ]
    
}

class ProductoTableViewController: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    static let shared = ProductoTableViewController()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Productos"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductoModel.shared.productos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productoCell")!
        
        var config = cell.defaultContentConfiguration()
        
        let producto = ProductoModel.shared.productos[indexPath.row]
        
        config.text = producto.nombre
        
        config.secondaryText = "$\(producto.precio)"
        
        cell.contentConfiguration = config
        
        return cell
    }
    
}

class ViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myTableView.dataSource = ProductoTableViewController.shared
        myTableView.delegate = ProductoTableViewController.shared
        
    }

}

