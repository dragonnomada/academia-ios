//
//  HomeViewController.swift
//  InventarioApp
//
//  Created by MacBook  on 05/01/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var productTableView: UITableView!
    
//    var productos: [ProductoEntity] = []
//    var transacciones: [TransaccionEntity] = []
    
    var productos: [(producto: ProductoEntity, transacciones: [TransaccionEntity])] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        //productTableView.estimatedRowHeight = 100
        //productTableView.rowHeight = UITableView.automaticDimension
        productTableView.dataSource = self
        productTableView.delegate = self
        productTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        // le de decimos al inventaryController que esta clase se va encargar de
        // definir los metodos del delegadoinventario homedelegate
        InventarioController.shared.inventarioHomeDelegate = self 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        InventarioController.shared.getAllproducts()
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
        return self.productos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let (producto, transacciones) = productos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        cell.setupCell(
            id: String(producto.id),
            nombre: producto.nombre ?? "",
            descripcion: producto.description,
            existencias: String(producto.existencias),
            imagen: producto.image,
            transacciones: transacciones
        )
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
    // Navegar a la vista de detalles cuando una fila es selecionada.
    ///
    ///otra cosa el sigue no se realiza aqui, tenemos que mandar a llamar Inventario Controller llamada selectPRODUCT
    ///
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        InventarioController.shared.selectProducto(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        500
    }

}
extension HomeViewController: InventarioHomeDelegate{
    ///
    ///
    ///
    func inventario(productos: [(producto: ProductoEntity, transacciones: [TransaccionEntity])]) {
        print("❖ Productos recibidos: \(productos)")
        self.productos = productos
        productTableView.reloadData()
    }
    
    func inventario(inventarioError error: String) {
        let alert = UIAlertController(title: "Error", message: "Error", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "error", style: .default))
        self.present(alert, animated: true)
    }
    
    func inventario(productoSeleccionado producto: ProductoEntity) {
        performSegue(withIdentifier: "Home-Details_Segue", sender: nil)
    }
    
    
}
