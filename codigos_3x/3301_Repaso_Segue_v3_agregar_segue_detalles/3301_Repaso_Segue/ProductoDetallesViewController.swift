//
//  ProductoDetallesViewController.swift
//  3301_Repaso_Segue
//
//  Created by User on 21/12/22.
//

import UIKit

class ProductoDetallesViewController: UIViewController {

    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var nombreLabel: UILabel!
    
    @IBOutlet weak var existenciasLabel: UILabel!
    
    @IBOutlet weak var precioLabel: UILabel!
    
    var producto: Producto? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let producto = producto {
            idLabel.text = "ID: \(producto.id)"
            nombreLabel.text = "\(producto.nombre)"
            precioLabel.text = "$\(producto.precio)"
            existenciasLabel.text = "\(producto.existencias)u"
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
