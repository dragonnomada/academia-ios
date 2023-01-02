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
    
    
    @IBOutlet weak var contratarButton: UIButton!
    
    //  cada switch como @IBOutlet
    @IBOutlet weak var actaNacimientoSwitch: UISwitch!
    @IBOutlet weak var curpSwitch: UISwitch!
    @IBOutlet weak var circuloCreditoSwitch: UISwitch!
    @IBOutlet weak var cedulaSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let prospecto = prospecto {
            actaNacimientoSwitch.isOn = prospecto.tieneActaNacimiento
            curpSwitch.isOn = prospecto.tieneCurp
            circuloCreditoSwitch.isOn = prospecto.tieneCirculoCredito
            cedulaSwitch.isOn = prospecto.tieneCedula
        }
        if prospecto?.tieneCedula == false || prospecto?.tieneCirculoCredito == false || prospecto?.tieneCurp == false || prospecto?.tieneActaNacimiento == false {
            contratarButton.isEnabled = false
        } else {
            contratarButton.isEnabled = true
        }
        
    }
    
    @IBAction func saveContratoActionButton(_ sender: Any) {
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

    @IBAction func actaNacimientoSwitchAction(_ sender: Any) {
        prospecto?.tieneActaNacimiento = actaNacimientoSwitch.isOn
        prospecto?.fechaActualizado = Date.now
    }
    
    @IBAction func curpSwitchAction(_ sender: Any) {
        prospecto?.tieneCurp = curpSwitch.isOn
        prospecto?.fechaActualizado = Date.now
    }
    
    @IBAction func circuloCreditoSwitchAction(_ sender: Any) {
        prospecto?.tieneCirculoCredito = circuloCreditoSwitch.isOn
        prospecto?.fechaActualizado = Date.now
    }
    
    @IBAction func cedulaSwitchAction(_ sender: Any) {
        prospecto?.tieneCedula = cedulaSwitch.isOn
        prospecto?.fechaActualizado = Date.now
    }
    
    
    @IBAction func completarContratoActionButton(_ sender: Any) {
        prospecto?.estado = "CONTRATADO"
    }
    

}
