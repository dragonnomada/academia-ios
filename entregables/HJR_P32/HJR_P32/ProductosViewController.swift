//
//  ViewController.swift
//  HJR_P32
//
//  Created by MacBook on 20/12/22.
//

import UIKit

class ProductosViewController: UIViewController {
    
    @IBOutlet weak var ProdcutosTableVIew: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProdcutosTableVIew.delegate = self
        ProdcutosTableVIew.dataSource = self
    }
}
// [1] Pasar a la siguiente pantalla a traves del segue (inicio de perform)
performSegue(withIdentifier: "mySegue", sender: productoSeleccionado)

// [2] Seguimiento de el sugue
func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Recuperar:
    // 1. El ViewController destino (segue.destination)
    // 2. Los datos que queremos enviar (sender)
    
    // Validar el id del segue
    if segue.identifier == "mySegue" {
        // Validar el destino
        if let productoDetallesViewController = segue.destination as? ProductoDetailViewController {
            
            // Pasamos el elemento deseado para mostrarlo en la siguiente pantalla
            if let productoSeleccionado = sender as? Producto {
                productoDetallesViewController.producto = productoSeleccionado
            }
        }
    }
}

// Repositorio ProductosRepository
class ProductosRepository {
    // Singleton
    static let main = ProductosRepository()
    
    var productos: [(nombre: String, precio: Double)] = [("Coca", 12.50), ("Galletas", 10), ("Agua", 15.50), ("Zucaritas", 32.0), ("Azucar", 20.30), ("Aceite", 24.60)]
    
}

// Estructura Producto
struct Producto {
    let nombre: String
    let precio: Double
}


// Extención para implementar UITableViewDataSource y UITableViewDelegate
extension ProductosViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Define cuantas secciones hay en la tabla
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Define cuál es el título para cada sección dada
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "PRODUCTOS"
    }
    
    // Define cuantas filas tendra cada sección
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductosRepository.main.productos.count
    }
    
    // Configuración de que y como se mostraran las celdas de cada sección deseada
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Recuperamos una celda desde tableView, pasandole su identificador "TableViewCell".
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductosTableViewCell")!
        cell.textLabel?.text = ProductosRepository.main.productos[indexPath.row].nombre
        cell.detailTextLabel?.text = "$\(ProductosRepository.main.productos[indexPath.row].precio)"
        return cell
    }
    /* Sección para que muestre que una celda fue seleccionada.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
     */
}
