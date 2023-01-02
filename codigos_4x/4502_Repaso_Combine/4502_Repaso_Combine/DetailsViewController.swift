//
//  DetailsViewController.swift
//  4502_Repaso_Combine
//
//  Created by Dragon on 30/12/22.
//

import UIKit
import Combine

class DetailsViewController: UIViewController {

    @IBOutlet weak var nombreLabel: UILabel!
    
    @IBOutlet weak var descripcionLabel: UILabel!
    
    @IBOutlet weak var precioLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let platillo = PlatillosController.shared.getPlatilloSeleccionado() {
            self.nombreLabel.text = platillo.nombre
            self.descripcionLabel.text = platillo.descripcion
            self.precioLabel.text = "$\(platillo.precio)"
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
