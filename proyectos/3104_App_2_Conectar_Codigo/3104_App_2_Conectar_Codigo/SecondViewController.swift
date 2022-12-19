//
//  SecondViewController.swift
//  3104_App_2_Conectar_Codigo
//
//  Created by User on 19/12/22.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pulsarBoton() {
        print("El botón fué pulsado")
        label?.text = "Hola mundo"
    }
    
}
