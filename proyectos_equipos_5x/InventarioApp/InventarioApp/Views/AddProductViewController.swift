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
        
        InventarioController.shared.inventarioAddProductDelegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancelar(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func agregar(_ sender: Any) {
        guard let nombre = addProductName.text else { return }
        guard let descripcion = addProductDescripcion.text else { return }
        guard let imagen = addProductImage.image?.pngData() else { return }
        
        InventarioController.shared.addProduct(nombre: nombre, imagen: imagen, descripcion: descripcion)
    }

}

extension AddProductViewController: InventarioAddProductDelegate {
    func inventario(productAdded producto: ProductoEntity) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func inventario(addProductError error: String) {
        self.present(UIAlertController.simpleErrorAlert(message: error), animated: true)
    }
    
    
}
