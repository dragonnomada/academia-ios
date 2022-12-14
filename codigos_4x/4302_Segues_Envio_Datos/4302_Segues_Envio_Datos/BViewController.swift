//
//  BViewController.swift
//  4302_Segues_Envio_Datos
//
//  Created by Dragon on 28/12/22.
//

import UIKit

class BViewController: UIViewController {
    
    /// **PASO 2** - Preparamos la llegada de una fruta opcionalmente
    /// Le avisamos a la pantalla **B** que espera una fruta opcional enviada desde
    /// desde otra pantalla
    var fruta: Fruta?
    
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var pesoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let fruta = fruta {
            
            print("[Pantalla B] He recibido la fruta: \(fruta)")
            
            nombreLabel.text = fruta.nombre
            pesoLabel.text = "\(fruta.peso) kg"
            
        }
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
