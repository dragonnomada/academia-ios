//
//  ValorarViewController.swift
//  NJJ_PI
//
//  Created by MacBook on 27/12/22.
//

import UIKit
import CoreData

class ValorarViewController: UIViewController {

    
    // TODO: Conectar el persistent
    var reclutappPersistentContainer: NSPersistentContainer?
    
    // TODO: Recibir el objeto persistente
    var prospecto: Prospecto?
    
    @IBOutlet weak var valorarButton: UIButton!
    
    //  cada switch como @IBOutlet
    @IBOutlet weak var sqlSwitch: UISwitch!
    @IBOutlet weak var pythonSwitch: UISwitch!
    @IBOutlet weak var promedioSwitch: UISwitch!
    @IBOutlet weak var mencionHonorificaSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let prospecto = prospecto {
            sqlSwitch.isOn = prospecto.tieneSql
            pythonSwitch.isOn = prospecto.tienePyhton
            promedioSwitch.isOn = prospecto.tieneAprobatorio
            mencionHonorificaSwitch.isOn = prospecto.tieneHonorifica
        }
        
        if prospecto?.tieneSql == false || prospecto?.tienePyhton == false || prospecto?.tieneAprobatorio == false || prospecto?.tieneHonorifica == false {
            valorarButton.isEnabled = false
        } else {
            valorarButton.isEnabled = true
        }
        
    }
    
    @IBAction func saveValorarAction(_ sender: Any) {
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
    
    
    @IBAction func sqlSwitchAction(_ sender: Any) {
        prospecto?.tieneSql = sqlSwitch.isOn
        prospecto?.fechaActualizado = Date.now
    }
    
    @IBAction func pythonSwitchAction(_ sender: Any) {
        prospecto?.tienePyhton = pythonSwitch.isOn
        prospecto?.fechaActualizado = Date.now
    }
    
    @IBAction func promedioSwitchAction(_ sender: Any) {
        prospecto?.tieneAprobatorio = promedioSwitch.isOn
        prospecto?.fechaActualizado = Date.now
    }
    
    @IBAction func completarValoraciónActionButton(_ sender: Any) {
        prospecto?.estado = "VALORADO"
    }
    
    @IBAction func honorificMentionSwitchAction(_ sender: Any) {
        prospecto?.tieneHonorifica   = mencionHonorificaSwitch.isOn
        prospecto?.fechaActualizado = Date.now
    }
    
    
}
