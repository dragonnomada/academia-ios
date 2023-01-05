//
//  CustomTableViewCell.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 04/01/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nombreLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var puestoLabel: UILabel!
    
    @IBOutlet weak var horarioLabel: UILabel!
    
    @IBOutlet weak var vacacionesLabel: UILabel!
    
    @IBOutlet weak var antiguedadLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    /// Funcion encargada de indicar que se ha seleccionado o se a presionado sobre una celda
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
