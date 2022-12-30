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
    
    //  cada switch como @IBOutlet
    @IBOutlet weak var sqlSwitch: UISwitch!
    @IBOutlet weak var pythonSwitch: UISwitch!
    @IBOutlet weak var promedioSwitch: UISwitch!
    @IBOutlet weak var mencionHonorificaSwitch: UISwitch!
    
    @IBAction func saveValorarAction(_ sender: Any) {
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
    
    
    @IBAction func sqlSwitchAction(_ sender: Any) {
        if sqlSwitch.isOn {
            prospecto?.tieneSql = true
            prospecto?.fechaActualizado = Date.now
        }
    }
    
    @IBAction func pythonSwitchAction(_ sender: Any) {
        
    }
    
    @IBAction func promedioSwitchAction(_ sender: Any) {
        
    }
    
    @IBAction func completarValoraciónActionButton(_ sender: Any) {
        
    }
    
    @IBAction func honorificMentionSwitchAction(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    
}
