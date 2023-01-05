//
//  NominaCustomTableViewCell.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 04/01/23.
//

import UIKit

class NominaCustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nombreNominaLabel: UILabel!
    
    @IBOutlet weak var fechaPagoLabel: UILabel!
    
    @IBOutlet weak var cantidadLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    /// Funcion encargada de indicar que se ha seleccionado o se a presionado sobre una celda
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
