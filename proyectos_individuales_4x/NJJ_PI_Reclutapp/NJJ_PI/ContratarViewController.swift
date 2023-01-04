//
//  ContratarViewController.swift
//  NJJ_PI
//  Joel Brayan Navor Jimenez (joelnavorjimenez@gmail.com)
//  Trabajo Creado el 27/12/22.
//  Proyecto Individual ReclutaApp
//  Created by MacBook on 27/12/22.
//

import UIKit
import CoreData

class ContratarViewController: UIViewController {
    
    
    /// Conexion al persistent Container
    var reclutappPersistentContainer: NSPersistentContainer?
    
    /// Instancia a prospecto de tipo Prospecto
    var prospecto: Prospecto?
    
    
    @IBOutlet weak var contratarButton: UIButton!
    
    /// Cada switch como @IBOutlet
    @IBOutlet weak var actaNacimientoSwitch: UISwitch!
    @IBOutlet weak var curpSwitch: UISwitch!
    @IBOutlet weak var circuloCreditoSwitch: UISwitch!
    @IBOutlet weak var cedulaSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Asosiación de cada switch al atributos del prospecto
        if let prospecto = prospecto {
            actaNacimientoSwitch.isOn = prospecto.tieneActaNacimiento
            curpSwitch.isOn = prospecto.tieneCurp
            circuloCreditoSwitch.isOn = prospecto.tieneCirculoCredito
            cedulaSwitch.isOn = prospecto.tieneCedula
        }
        /// Comprobación de que los switches esten todos "on" para permitir cambiar el esto del prospecto al presionar el botón
        if prospecto?.tieneCedula == false || prospecto?.tieneCirculoCredito == false || prospecto?.tieneCurp == false || prospecto?.tieneActaNacimiento == false {
            contratarButton.isEnabled = false
        } else {
            contratarButton.isEnabled = true
        }
        
    }
    
    @IBAction func saveContratoActionButton(_ sender: Any) {
        if let context = reclutappPersistentContainer?.viewContext {
            /// Recuperación del contexto
            print("Recuperé el contexto: TIENE CAMBIOS? \(context.hasChanges ? "SI" : "NO")")
            do {
                try context.save()
                /// Guardar los cambios en el contexto
                print("Se guardó el prospecto")
                self.navigationController?.popViewController(animated: true)
            } catch {
                /// Si ocurre algun error damos roll back
                context.rollback()
                print("NO PUDE GUARDAR EL CONTEXTO AL ENTREVISTAR")
            }
        }
    }

    /// Switchs que al activarse indicara que el prospecto cuenta con cada uno de los atributos que se presentan a continuación solo si cuenta con cada uno.
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
    
    /// Botón que all presionarse cambiara el estado del prospecto a contratado.
    @IBAction func completarContratoActionButton(_ sender: Any) {
        prospecto?.estado = "CONTRATADO"
    }
    

}
