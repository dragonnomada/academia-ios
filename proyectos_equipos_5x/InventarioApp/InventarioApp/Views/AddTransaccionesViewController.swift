//
//  AddTransaccionesViewController.swift
//  InventarioApp
//
//  Created by MacBook  on 05/01/23.
//

import UIKit

class AddTransaccionesViewController: UIViewController {
    
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameView: UILabel!
    @IBOutlet weak var productDescripcionView: UILabel!
    @IBOutlet weak var productIdView: UILabel!
    @IBOutlet weak var productExistenciasView: UILabel!
    
    @IBOutlet weak var transaccionEntradaSwitch: UISwitch!
    @IBOutlet weak var productIngresar: UITextField!
    
    var transacciones: [TransaccionEntity] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        InventarioController.shared.inventarioAddEntradaDelegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        InventarioController.shared.getSelectedProduct()
    }
    
    @IBAction func cancelar(_ sender: Any) {
        //
    }
    @IBAction func agregar(_ sender: Any) {
        guard let unidadesText = productIngresar.text else { return }
        guard let unidades = Int(unidadesText) else { return }
        
        InventarioController.shared.addSelectedProductTransaccion(entrada: transaccionEntradaSwitch.isOn, unidades: unidades)
    }

}

extension AddTransaccionesViewController: InventarioAddEntradaDelegate {
    
    func inventario(transaccionCreada transaccion: TransaccionEntity) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func inventario(productSelected product: ProductoEntity) {
        productNameView.text = product.nombre
        if let imagen = product.image {
            productImageView.image = UIImage(data: imagen)
        }
        productDescripcionView.text = product.descripcion
        productExistenciasView.text = "\(product.existencias)"
    }
    
    func inventario(addTransaccionError error: String) {
        self.present(UIAlertController.simpleErrorAlert(message: error), animated: true)
    }
    
    
    
    
}


