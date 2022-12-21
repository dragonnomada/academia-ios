//
//  ViewController.swift
//  BTE_P32
//
//  Created by MacBook Pro on 20/12/22.
//

import UIKit
struct Producto {
    let id: String
    let descripcion: String
    let precio: Double
    let existencias: Int
}
class ProductosRepository {
    static let main = ProductosRepository()
    var producto: [Producto] = [
        Producto(id: "10", descripcion: "Taza", precio: 125.15, existencias: 10),
        Producto(id: "20", descripcion: "Cafetera", precio: 1200.20, existencias: 3),
        Producto(id: "30", descripcion: "Cargador", precio: 600.50, existencias: 8),
        Producto(id: "40", descripcion: "Mac-Book Pro", precio: 45800.20 , existencias: 6),
        Producto(id: "50", descripcion: "Folder", precio: 4.5, existencias: 2),
        Producto(id: "60", descripcion: "Mouse", precio: 150.7, existencias: 1),
        Producto(id: "70", descripcion: "Mochila", precio: 600.00 , existencias: 4),
        Producto(id: "80", descripcion: "Control", precio: 350.00 , existencias: 3),
        Producto(id: "90", descripcion: "Telefono", precio: 200.00, existencias: 1)
    ]
}


class ViewController: UIViewController {

    
    @IBOutlet weak var myTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myTableView.dataSource = self
        myTableView.delegate = self
    }


    
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Productos"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductosRepository.main.producto.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewCellProductos")!
        
        cell.textLabel?.text = ProductosRepository.main.producto[indexPath.row].descripcion
        cell.detailTextLabel?.text = "$\(ProductosRepository.main.producto[indexPath.row].precio)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detallesProductoSegue", sender: ProductosRepository.main.producto[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detallesProductoSegue" {
            guard let productoDetailViewController = segue.destination as? ProductoDetailViewController else { return }
            guard let producto = sender as? Producto else { return }
            
            productoDetailViewController.producto =  producto
        }
    }
    
}
