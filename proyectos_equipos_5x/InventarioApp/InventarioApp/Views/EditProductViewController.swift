//
//  EditViewController.swift
//  InventarioApp
//
//  Created by Alan Badillo on 05/01/23.
//

import UIKit

class EditProductViewController: UIViewController {
    
    @IBOutlet weak var editproductImage: UIImageView!
    @IBOutlet weak var editProductName: UITextField!
    @IBOutlet weak var editProductdescripcion: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        InventarioController.shared.inventarioEditProductDelegate = self
    }

    @IBAction func cancelar(_ sender: Any) {
        //
    }
    
    @IBAction func agregar(_ sender: Any) {
        let nombre = editProductName.text
        let imagen = editproductImage.image?.pngData()
        InventarioController.shared.editProduct(nombre: nombre, imagen: imagen, descripcion: editProductdescripcion.text)
    }
    
}

extension EditProductViewController: InventarioEditProductDelegate {
    func inventario(productEditted: ProductoEntity) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func inventario(editError: String) {
        let alert = UIAlertController(title: "Error", message: editError, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        
        self.present(alert, animated: true)
    }
    
    
}
