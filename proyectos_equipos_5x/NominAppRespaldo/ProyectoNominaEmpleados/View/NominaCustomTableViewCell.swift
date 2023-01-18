//
// Proyecto: NominApp
//
// Autores:
// Joel Brayan Navor Jimenez
// Brian Jimenez Moedano
// Heber Eduardo Jimenez Rodriguez
//
// Creado el 4 de enero del 2023
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
