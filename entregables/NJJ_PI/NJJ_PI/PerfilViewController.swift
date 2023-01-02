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
        if prospecto?.estado == "RECLUTADO" {
            
        }
    }
    
    @IBAction func valorarActionLabel(_ sender: Any) {
        if prospecto?.estado == "ENTREVISTADO" {
            
        }
    }
    
    @IBAction func contratarLabel(_ sender: Any) {
        if prospecto?.estado == "VALORADO" {
            
        }
    }
    
    @IBOutlet weak var entrevistarIconLabel: UILabel!
    
    @IBOutlet weak var valorarIconLabel: UILabel!
    
    @IBOutlet weak var contratarIconLabel: UILabel!
    
    @IBOutlet weak var nombreLabel: UILabel!
    
    @IBOutlet weak var estadoLabel: UILabel!
    
    @IBOutlet weak var fechaInicioLabel: UILabel!
    
    @IBOutlet weak var perfilImageView: UIImageView!
    
    @IBOutlet weak var fechaActualizadoLabel: UILabel!
    
    @IBOutlet weak var diasEstimadosLabel: UILabel!
    
    @IBOutlet weak var diasRetrasoLabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier  {
        case "EntrevistarSegue":
            
            if let entrevistarViewController = segue.destination as? EntrevistarViewController {
                
                entrevistarViewController.reclutappPersistentContainer = prospectoPersistentContainer
                
                entrevistarViewController.prospecto = prospecto
                
            }
        case "ValorarSegue":
            
            if let valorarViewController = segue.destination as? ValorarViewController {
                
                valorarViewController.reclutappPersistentContainer = prospectoPersistentContainer
                
                valorarViewController.prospecto = prospecto
            }
        case "ContratarSegue":
            
            if let contratarViewController = segue.destination as? ContratarViewController {
                
                contratarViewController.reclutappPersistentContainer = prospectoPersistentContainer
                
                contratarViewController.prospecto = prospecto
            }
        default:
            print("Caso default")
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        perfilImageView.layer.cornerRadius = perfilImageView.bounds.size.width / 2.0
        
        if let prospecto = prospecto {
            
            switch prospecto.estado {
            case "ENTREVISTADO":
                entrevistarIconLabel.text = "✅"
                valorarIconLabel.text = "➡️"
                contratarIconLabel.text = "⌛️"
            case "VALORADO":
                entrevistarIconLabel.text = "✅"
                valorarIconLabel.text = "✅"
                contratarIconLabel.text = "➡️"
            case "CONTRATADO":
                entrevistarIconLabel.text = "✅"
                valorarIconLabel.text = "✅"
                contratarIconLabel.text = "✅"
            default:
                entrevistarIconLabel.text = "➡️"
                valorarIconLabel.text = "⌛️"
                contratarIconLabel.text = "⌛️"
            }
            
            if let nombreProspecto = prospecto.nombre {
                let apellidoP = prospecto.apellidoPaterno
                let apellidoM = prospecto.apellidoMaterno
                nombreLabel.text = "\(apellidoP ?? "") \(apellidoM ?? ""), \(nombreProspecto)"
            }
            
            if let estadoProspecto = prospecto.estado {
                estadoLabel.text = estadoProspecto
            }
            
            if let fechaInicio = prospecto.fechaInicio {
                fechaInicioLabel.text = "\(fechaInicio.toString())"
            }
            
            if let fechaActualizado = prospecto.fechaActualizado {
                fechaActualizadoLabel.text = "\(fechaActualizado.toString())"
            }
        }

    }
    
}

    


