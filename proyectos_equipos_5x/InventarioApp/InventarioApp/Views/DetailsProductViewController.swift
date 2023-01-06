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
    
    
    var producto: ProductoEntity?
    var transacciones: [TransaccionEntity] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        transaccionesTableView.dataSource = self
        //tableView.delegate = self
        
        InventarioController.shared.inventarioDetailsDelegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        InventarioController.shared.getSelectedProduct()
    }
    
    @IBAction func agregarTransaccion(_ sender: Any) {
        // Segue automático
    }

}

extension DetailsProductViewController: InventarioDetailsDelegate {
    
    func inventario(productoSelected producto: ProductoEntity, transacciones: [TransaccionEntity]) {
        self.producto = producto
        self.transacciones = transacciones
        
        self.productNameView.text = producto.nombre
        self.productDescripcionView.text = producto.descripcion
        if let imagen = producto.image {
            self.productImageView.image = UIImage(data: imagen)
        }
        self.productExistenciasView.text = "\(producto.existencias)"
        
        self.transaccionesTableView.reloadData()
    }
    
    func inventario(filterTransactionsError error: String) {
        self.present(UIAlertController.simpleErrorAlert(message: error), animated: true)
    }
    
    func inventario(selectProductError error: String) {
        self.present(UIAlertController.simpleErrorAlert(message: error), animated: true)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransaccionCell")!
        
        let transaccion = self.transacciones[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        
        config.text = "\(transaccion.entrada ? "⬆️" : "⬇️")"
        config.secondaryText = "\(transaccion.entrada ? "+" : "-")\(transaccion.unidades) ➡️ \(transaccion.balance)"
        
        cell.contentConfiguration = config
        
        return cell
    }
}

//extension DetailsProductViewController: UITableViewDelegate{
//    // Navegar a la vista de detalles cuando una fila es selecionada
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "", sender: nil)
//    }
//}

