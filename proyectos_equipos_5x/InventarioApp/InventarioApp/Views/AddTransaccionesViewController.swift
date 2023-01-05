//
//  AddTransaccionesViewController.swift
//  InventarioApp
//
//  Created by MacBook  on 05/01/23.
//

import UIKit

class AddTransaccionesViewController: UIViewController {
    
    
    @IBOutlet weak var productImageView: UIImage!
    @IBOutlet weak var productNameView: UILabel!
    @IBOutlet weak var productDescripcionView: UILabel!
    @IBOutlet weak var productIdView: UILabel!
    @IBOutlet weak var productExistenciasView: UILabel!
    
    @IBOutlet weak var ProductIngresar: UITextField!
    
    var transacciones: [TransaccionEntity] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func cancelar(_ sender: Any) {
        //
    }
    @IBAction func agregar(_ sender: Any) {
        // 
    }

}


