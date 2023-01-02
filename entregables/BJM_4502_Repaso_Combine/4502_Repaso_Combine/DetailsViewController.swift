//
//  DetailsViewController.swift
//  4502_Repaso_Combine
//
//  Created by User on 30/12/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var nombreLabel: UILabel!
    
    @IBOutlet weak var descripcionLabel: UILabel!
    
    @IBOutlet weak var precioLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let platilloSeleccionado = PlatillosController.shared.getPlatilloSeleccionado() {
            
            nombreLabel.text = platilloSeleccionado.nombre
            descripcionLabel.text = platilloSeleccionado.descripcion
            precioLabel.text = ("$\(platilloSeleccionado.precio)")
        }
    }

}
