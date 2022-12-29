//
//  EntrevistarViewController.swift
//  NJJ_PI
//
//  Created by MacBook on 27/12/22.
//

import UIKit
import CoreData

class EntrevistarViewController: UIViewController {
    
    // TODO: Conectar el persistent
    var reclutappPersistentContainer: NSPersistentContainer?
    
    // TODO: Recibir el objeto persistente
    var prospecto: Prospecto?
    
    // TODO: Conectar el cada switch como @IBOutlet
    @IBOutlet weak var psicometricSwitch: UISwitch!
    @IBOutlet weak var aptitudesSwitch: UISwitch!
    @IBOutlet weak var examenFisicoSwitch: UISwitch!
    @IBOutlet weak var examenHabilidadesSwitch: UISwitch!
    
    @IBAction func saveEntrevistarAction(_ sender: Any) {
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
    
    @IBAction func psicometricSwitchAction(_ sender: Any) {
        if psicometricSwitch.isOn {
            prospecto?.tienePsicometric = true
            prospecto?.fechaActualizado = Date.now
        }
    }
    
    
    @IBAction func aptitudesSwitchAction(_ sender: Any) {
        if psicometricSwitch.isOn {
            prospecto?.examenAptitudes = true
            prospecto?.fechaActualizado = Date.now
        }
    }
    
    @IBAction func fisicoSwitchAction(_ sender: Any) {
        if psicometricSwitch.isOn {
            prospecto?.examenFisico = true
            prospecto?.fechaActualizado = Date.now
        }
    }
    
    @IBAction func HabilidadesSwitchAction(_ sender: Any) {
        if psicometricSwitch.isOn {
            prospecto?.tieneExamenHabilidades = true
            prospecto?.fechaActualizado = Date.now
        }
    }
    
    
    @IBAction func completarEntrevistaActionButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

   

}
