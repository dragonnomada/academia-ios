//
//  CustomTableViewCell.swift
//  NJJ_PI
//  Joel Brayan Navor Jimenez (joelnavorjimenez@gmail.com)
//  Trabajo Creado el 27/12/22.
//  Proyecto Individual ReclutaApp
//  Created by MacBook on 27/12/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    /// Conexiones a la celda custom
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var nombreLabel: UILabel!
    
    @IBOutlet weak var estadoLabel: UILabel!
    
    @IBOutlet weak var fechaInicioLabel: UILabel!
    
    @IBOutlet weak var fechaActualizadoLabel: UILabel!
    
    @IBOutlet weak var estimadoLabel: UILabel!
    
    @IBOutlet weak var retrasoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /// Propiedades para hacer una imagen redonda
        myImageView.layer.cornerRadius = myImageView.bounds.size.width / 2.0
    }
    /// Funcion encargada de indicar que se ha seleccionado o se a presionado sobre una celda
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
