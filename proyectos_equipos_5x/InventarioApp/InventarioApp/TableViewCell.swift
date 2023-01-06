//
//  TableViewCell.swift
//  InventarioApp
//
//  Created by MacBook Pro on 04/01/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageProducto: UIImageView!
    
    @IBOutlet weak var idProductoLabel: UILabel!
    
    @IBOutlet weak var nombreProductoLabel: UILabel!
    
    @IBOutlet weak var descripcionProductoLabel: UILabel!
    
    @IBOutlet weak var existenciasLabel: UILabel!
    
    @IBOutlet weak var transaccionesTableView: UITableView!
    
    var transacciones: [TransaccionEntity] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        //transaccionesTableView.estimatedRowHeight = 20
        //transaccionesTableView.rowHeight = UITableView.automaticDimension
        
        transaccionesTableView.register(UINib(nibName: "TransaccionTableTableViewCell", bundle: nil), forCellReuseIdentifier: "TransaccionDetallesCell")
        
        transaccionesTableView.dataSource = self
        //transaccionesTableView.delegate = self
        
    }
//    TODO: Crear una entrada de Imagen
    func setupCell( id: String, nombre: String, descripcion: String, existencias: String, imagen: Data?, transacciones: [TransaccionEntity]) {
        //self.imageProducto = imageProducto // Casteo
        self.idProductoLabel.text = id
        self.nombreProductoLabel.text = nombre
        self.descripcionProductoLabel.text = descripcion
        self.existenciasLabel.text = existencias
        if let image = imagen {
            imageProducto.image = UIImage(data: image)
        }
        self.transacciones = transacciones
        self.transaccionesTableView.reloadData()
    }
        
}

extension TableViewCell: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Últimas 3 transacciones"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Transacciones: \(transacciones.count)")
        return min(3, transacciones.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let transaccion = transacciones[indexPath.row]
        let cell = transaccionesTableView.dequeueReusableCell(withIdentifier: "TransaccionDetallesCell", for: indexPath) as! TransaccionTableTableViewCell
        print("PINTANDO CELDA PARA LA TRANSACCIÓN: \(transaccion)")
        cell.setupCell(transaccion: transaccion)
        return cell
    }
}
