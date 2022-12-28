//
//  BViewController.swift
//  4302_Segues_Envio_Datos
//
//  Created by User on 28/12/22.
//

import UIKit

class BViewController: UIViewController {
    
    @IBOutlet weak var nombreLabel: UILabel!
    
    @IBOutlet weak var pesoLabel: UILabel!
    
    ///
    ///**PASO 2** - Preparamos la llegada de una fruta opcionalmente
    ///Le avisamos a la pantalla **B** que espera una fruta opcional enviada desde
    ///otra pantalla
    ///
    var fruta: Fruta?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let fruta = fruta {
            print("[Pantalla B] He recibido la fruta: \(fruta)")
            
            nombreLabel.text = fruta.nombre
            pesoLabel.text = "\(fruta.peso) kg"
        }

    }
    


}
