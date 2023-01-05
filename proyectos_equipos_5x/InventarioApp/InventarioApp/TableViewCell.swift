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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
