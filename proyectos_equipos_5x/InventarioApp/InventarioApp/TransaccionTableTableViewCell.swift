//
//  TransaccionTableTableViewCell.swift
//  InventarioApp
//
//  Created by MacBook  on 06/01/23.
//

import UIKit

class TransaccionTableTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconLabel:UILabel!
    @IBOutlet weak var UnidadesLabel: UILabel!
    @IBOutlet weak var balancelabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(transaccion: TransaccionEntity) {
        iconLabel.text = transaccion.entrada ? "▲" : "▼"
        UnidadesLabel.text = "\(transaccion.entrada ? "+" : "-")\(transaccion.unidades)"
        balancelabel.text = String(transaccion.balance)
    }
    
}
