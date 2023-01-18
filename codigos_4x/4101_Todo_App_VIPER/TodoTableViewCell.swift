//
//  TodoTableViewCell.swift
//  40101_Todo_App_VIPER
//
//  Created by Dragon on 26/12/22.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var rightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
