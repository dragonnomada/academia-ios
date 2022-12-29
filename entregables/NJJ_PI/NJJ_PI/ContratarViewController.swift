//
//  ContratarViewController.swift
//  NJJ_PI
//
//  Created by MacBook on 27/12/22.
//

import UIKit
import CoreData

class ContratarViewController: UIViewController {
    
    
    // TODO: Conectar el persistent
    var reclutappPersistentContainer: NSPersistentContainer?
    
    // TODO: Recibir el objeto persistente
    var prospecto: Prospecto?
    
    //  cada switch como @IBOutlet
    @IBOutlet weak var actaNacimientoSwitch: UISwitch!
    @IBOutlet weak var curpSwitch: UISwitch!
    @IBOutlet weak var circuloCreditoSwitch: UISwitch!
    @IBOutlet weak var cedulaSwitch: UISwitch!
    
    
    @IBAction func saveContratoActionButton(_ sender: Any) {
        if let context = reclutappPersistentContainer?.viewContext {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    context.rollback()
                }
            }
        }
    }

    @IBAction func actaNacimientoSwitchAction(_ sender: Any) {
        
    }
    
    @IBAction func curpSwitchAction(_ sender: Any) {
        
    }
    
    @IBAction func circuloCreditoSwitchAction(_ sender: Any) {
        
    }
    
    @IBAction func cedulaSwitchAction(_ sender: Any) {
        
    }
    
    
    @IBAction func completarContratoActionButton(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    

}
