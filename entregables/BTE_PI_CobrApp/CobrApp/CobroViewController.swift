//
//  CobroViewController.swift
//  CobrApp
//
//  Created by MacBook Pro on 28/12/22.
//

import UIKit

extension UIImageView {
    
    func fromURL(string: String) {
        if let url = URL(string: string) {
            
            let session = URLSession.shared.dataTask(with: url) {
                
                data, response, error in
                
                if let data = data {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                    }
                }
                
            }
            
            session.resume()
            
        }
    }
    
}

class CobroViewController: UIViewController {
    
    var producto: Producto?
    
    
    @IBOutlet weak var productoImageView: UIImageView!

    @IBOutlet weak var descripcionTiendaLabel: UILabel!
    
    @IBOutlet weak var descripcionProductoLabel: UILabel!
    
    @IBOutlet weak var montoCobroLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.productoImageView.layer.cornerRadius = self.productoImageView.bounds.size.width / 2.0
        
        if let producto = producto {
            self.productoImageView.fromURL(string: producto.imagenURL)
            self.descripcionTiendaLabel.text = producto.descripcionCargo
            self.descripcionProductoLabel.text = producto.descripcionProducto
            self.montoCobroLabel.text = "$\(producto.monto)"
        }
    }
    
    @IBAction func confirmarActionPress(_ sender: Any) {
        performSegue(withIdentifier: "ValidoQR-ValidoCobro-Segue", sender: nil)
    }
    
    @IBAction func cancelarActionPress(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
