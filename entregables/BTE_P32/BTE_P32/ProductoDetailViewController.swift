//
//  ProductoDetailViewController.swift
//  BTE_P32
//
//  Created by MacBook Pro on 20/12/22.
//

import UIKit

class ProductoDetailViewController: UIViewController {

    @IBOutlet weak var id: UILabel!
    var producto: Producto?
    
    @IBOutlet weak var descripcion: UILabel!
    
    @IBOutlet weak var existencia: UILabel!
    
    @IBOutlet weak var precio: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let producto = producto else { return }
        id.text = "\(producto.id)"
        descripcion.text = producto.descripcion
        existencia.text = "\(producto.existencias)"
        precio.text = "$\(producto.precio)"

        // Do any additional setup after loading the view.
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
