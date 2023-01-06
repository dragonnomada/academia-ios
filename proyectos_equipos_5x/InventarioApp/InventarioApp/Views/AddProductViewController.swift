//
//  AddViewController.swift
//  InventarioApp
//
//  Created by MacBook  on 05/01/23.
//

import UIKit

class AddProductViewController: UIViewController {

    @IBOutlet weak var addProductImage: UIImageView!
    @IBOutlet weak var addProductName: UITextField!
    @IBOutlet weak var addProductDescripcion: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        InventarioController.shared.inventarioEditProductDelegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancelar(_ sender: Any) {
        performSegue(withIdentifier: "", sender: self)
    }
    
    @IBAction func agregar(_ sender: Any) {
        //
    }

}

extension AddProductViewController: InventarioAddProductDelegate {
    func inventario(productAdded producto: ProductoEntity) {
        <#code#>
    }
    
    func inventario(addProductError error: String) {
        <#code#>
    }
    
    
}
