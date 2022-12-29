//
//  CustomTableViewCell.swift
//  NJJ_PI
//
//  Created by MacBook on 27/12/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var nombreLabel: UILabel!
    
    @IBOutlet weak var estadoLabel: UILabel!
    
    @IBOutlet weak var fechaInicioLabel: UILabel!
    
    @IBOutlet weak var fechaActualizadoLabel: UILabel!
    
    @IBOutlet weak var estimadoLabel: UILabel!
    
    @IBOutlet weak var retrasoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myImageView.layer.cornerRadius = myImageView.bounds.size.width / 2.0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
