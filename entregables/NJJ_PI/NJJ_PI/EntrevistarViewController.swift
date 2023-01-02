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
    
    @IBOutlet weak var entrevistarButton: UIButton!
    
    // TODO: Conectar el cada switch como @IBOutlet
    @IBOutlet weak var psicometricSwitch: UISwitch!
    @IBOutlet weak var aptitudesSwitch: UISwitch!
    @IBOutlet weak var examenFisicoSwitch: UISwitch!
    @IBOutlet weak var examenHabilidadesSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let prospecto = prospecto {
            psicometricSwitch.isOn = prospecto.tienePsicometric
            aptitudesSwitch.isOn = prospecto.examenAptitudes
            examenFisicoSwitch.isOn = prospecto.examenFisico
            examenHabilidadesSwitch.isOn = prospecto.tieneExamenHabilidades
        }
        
        if prospecto?.tienePsicometric == false || prospecto?.examenAptitudes == false || prospecto?.examenFisico == false || prospecto?.tieneExamenHabilidades == false {
            entrevistarButton.isEnabled = false
        } else {
            entrevistarButton.isEnabled = true
        }
        
    }
    
    @IBAction func saveEntrevistarAction(_ sender: Any) {
        if let context = reclutappPersistentContainer?.viewContext {
            print("Recuperé el contexto: TIENE CAMBIOS? \(context.hasChanges ? "SI" : "NO")")
            do {
                try context.save()
                print("Se guardó el prospecto")
                self.navigationController?.popViewController(animated: true)
            } catch {
                context.rollback()
                print("NO PUDE GUARDAR EL CONTEXTO AL ENTREVISTAR")
            }
        }
    }
    
    @IBAction func psicometricSwitchAction(_ sender: Any) {
        prospecto?.tienePsicometric = psicometricSwitch.isOn
        prospecto?.fechaActualizado = Date.now
    }
    
    
    @IBAction func aptitudesSwitchAction(_ sender: Any) {
        prospecto?.examenAptitudes = psicometricSwitch.isOn
        prospecto?.fechaActualizado = Date.now
    }
    
    @IBAction func fisicoSwitchAction(_ sender: Any) {
        prospecto?.examenFisico = psicometricSwitch.isOn
        prospecto?.fechaActualizado = Date.now
    }
    
    @IBAction func HabilidadesSwitchAction(_ sender: Any) {
        prospecto?.tieneExamenHabilidades = psicometricSwitch.isOn
        prospecto?.fechaActualizado = Date.now
    }
    
    
    @IBAction func completarEntrevistaActionButton(_ sender: Any) {
        prospecto?.estado = "ENTREVISTADO"
    }
    

   

}
