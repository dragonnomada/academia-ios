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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    TODO: Crear una entrada de Imagen
    func setupCell( id: String, nombre: String, descripcion: String, existencias: String) {
        //self.imageProducto = imageProducto // Casteo
        self.idProductoLabel.text = id
        self.nombreProductoLabel.text = nombre
        self.descripcionProductoLabel.text = descripcion
        self.existenciasLabel.text = existencias
    }
        
}
