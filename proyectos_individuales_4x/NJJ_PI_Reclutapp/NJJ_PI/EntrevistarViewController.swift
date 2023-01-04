//
//  EntrevistarViewController.swift
//  NJJ_PI
//  Joel Brayan Navor Jimenez (joelnavorjimenez@gmail.com)
//  Trabajo Creado el 27/12/22.
//  Proyecto Individual ReclutaApp
//  Created by MacBook on 27/12/22.
//

import UIKit
import CoreData

class EntrevistarViewController: UIViewController {
    
    /// Conexion al persistent Container
    var reclutappPersistentContainer: NSPersistentContainer?
    
    /// Instancia a prospecto de tipo Prospecto
    var prospecto: Prospecto?
    
    @IBOutlet weak var entrevistarButton: UIButton!
    
    /// Cada switch como @IBOutlet
    @IBOutlet weak var psicometricSwitch: UISwitch!
    @IBOutlet weak var aptitudesSwitch: UISwitch!
    @IBOutlet weak var examenFisicoSwitch: UISwitch!
    @IBOutlet weak var examenHabilidadesSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Asosiación de cada switch al atributos del prospecto
        if let prospecto = prospecto {
            psicometricSwitch.isOn = prospecto.tienePsicometric
            aptitudesSwitch.isOn = prospecto.examenAptitudes
            examenFisicoSwitch.isOn = prospecto.examenFisico
            examenHabilidadesSwitch.isOn = prospecto.tieneExamenHabilidades
        }
        
        /// Función para guardar el estado de los switches enlazados a los atributos del prospecto
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
    /// Switchs que al activarse indicara que el prospecto cuenta con cada uno de los atributos que se presentan a continuación solo si cuenta con cada uno.
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
    
    /// Botón que al presionarse cambiara el estado del prospecto a entrevistado.
    @IBAction func completarEntrevistaActionButton(_ sender: Any) {
        prospecto?.estado = "ENTREVISTADO"
    }
    

   

}
