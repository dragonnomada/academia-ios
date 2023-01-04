//
//  ValorarViewController.swift
//  NJJ_PI
//  Joel Brayan Navor Jimenez (joelnavorjimenez@gmail.com)
//  Trabajo Creado el 27/12/22.
//  Proyecto Individual ReclutaApp
//  Created by MacBook on 27/12/22.
//

import UIKit
import CoreData

class ValorarViewController: UIViewController {

    
    /// Conexion al persistent Container
    var reclutappPersistentContainer: NSPersistentContainer?
    
    /// Instancia a prospecto de tipo Prospecto
    var prospecto: Prospecto?
    
    @IBOutlet weak var valorarButton: UIButton!
    
    /// Cada switch como @IBOutlet
    @IBOutlet weak var sqlSwitch: UISwitch!
    @IBOutlet weak var pythonSwitch: UISwitch!
    @IBOutlet weak var promedioSwitch: UISwitch!
    @IBOutlet weak var mencionHonorificaSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Asosiación de cada switch al atributos del prospecto
        if let prospecto = prospecto {
            sqlSwitch.isOn = prospecto.tieneSql
            pythonSwitch.isOn = prospecto.tienePyhton
            promedioSwitch.isOn = prospecto.tieneAprobatorio
            mencionHonorificaSwitch.isOn = prospecto.tieneHonorifica
        }
        /// Comprobación de que los switches esten todos "on" para permitir cambiar el esto del prospecto al presionar el botón
        if prospecto?.tieneSql == false || prospecto?.tienePyhton == false || prospecto?.tieneAprobatorio == false || prospecto?.tieneHonorifica == false {
            valorarButton.isEnabled = false
        } else {
            valorarButton.isEnabled = true
        }
        
    }
    /// Función para guardar el estado de los switches enlazados a los atributos del prospecto
    @IBAction func saveValorarAction(_ sender: Any) {
        /// Recuperación del contexto
        if let context = reclutappPersistentContainer?.viewContext {
            print("Recuperé el contexto: TIENE CAMBIOS? \(context.hasChanges ? "SI" : "NO")")
            do {
                /// Guardar los cambios en el contexto
                try context.save()
                /// Animación ejecutada al presionar el botón
                self.navigationController?.popViewController(animated: true)
            } catch {
                /// Si ocurre algun error ejecutar rollback()
                context.rollback()
                
            }
        }
    }
    
    /// Switchs que al activarse indicara que el prospecto cuenta con cada uno de los atributos que se presentan a continuación solo si cuenta con cada uno.
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
    /// Botón para cambiar el estado a "VALORADO"
    @IBAction func completarValoraciónActionButton(_ sender: Any) {
        prospecto?.estado = "VALORADO"
    }
    
    @IBAction func honorificMentionSwitchAction(_ sender: Any) {
        prospecto?.tieneHonorifica   = mencionHonorificaSwitch.isOn
        prospecto?.fechaActualizado = Date.now
    }
    
    
}
