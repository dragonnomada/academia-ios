//
//  PerfilViewController.swift
//  NJJ_PI
//
//  Created by MacBook on 27/12/22.
//

import UIKit
import CoreData

class PerfilViewController: UIViewController, UITextViewDelegate {
    
    var prospectoPersistentContainer: NSPersistentContainer?
    ///Variable hecha para avisarle a mi PerfilView que va a recibir un prospecto dado por el perform y su didselectrow
    var prospecto: Prospecto?
    
    @IBAction func entrevistarActionButton(_ sender: Any) {
    }
    
    @IBAction func valorarActionLabel(_ sender: Any) {
    }
    
    @IBAction func contratarLabel(_ sender: Any) {
    }
    
    @IBOutlet weak var entrevistarIconLabel: UILabel!
    
    @IBOutlet weak var valorarIconLabel: UILabel!
    
    @IBOutlet weak var contratarIconLabel: UILabel!
    
    @IBOutlet weak var nombreLabel: UILabel!
    
    @IBOutlet weak var estadoLabel: UILabel!
    
    @IBOutlet weak var fechaInicioLabel: UILabel!
    
    @IBOutlet weak var fechaActualizadoLabel: UILabel!
    
    @IBOutlet weak var diasEstimadosLabel: UILabel!
    
    @IBOutlet weak var diasRetrasoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let prospecto = prospecto {
            nombreLabel.text = "\(prospecto.apellidoPaterno) \(prospecto.apellidoMaterno), \(prospecto.nombre)"
            estadoLabel.text = prospecto.estado
            fechaInicioLabel.text = "\(prospecto.fechaInicio)"
            fechaActualizadoLabel.text = "\(prospecto.fechaActualizado)"
            
        }
        

    }
}
    
    


