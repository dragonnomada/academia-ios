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
    
    override func viewWillAppear(_ animated: Bool) {
        InventarioController.shared.getSelectedProduct()
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
    
    func inventario(productLoaded: ProductoEntity) {
        editProductName.text = productLoaded.nombre
        editProductdescripcion.text = productLoaded.descripcion
    }
    
    func inventario(productEditted: ProductoEntity) {
        print("Producto actualizado")
        self.navigationController?.popViewController(animated: true)
    }
    
    func inventario(editError: String) {
        let alert = UIAlertController(title: "Error", message: editError, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        
        self.present(alert, animated: true)
    }
    
    
}
