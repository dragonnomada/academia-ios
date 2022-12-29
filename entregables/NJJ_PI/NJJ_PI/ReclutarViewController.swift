//
//  ReclutarViewController.swift
//  NJJ_PI
//
//  Created by MacBook on 27/12/22.
//

import UIKit
import CoreData


class ReclutarViewController: UIViewController, UITextViewDelegate {
    
    var prospectosModel: NSPersistentContainer?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var agregarImagenButton: UIButton!
    
    @IBOutlet weak var nombreTextField: UITextField!
    
    @IBOutlet weak var apellidoPaternoTextField: UITextField!
    
    @IBOutlet weak var apellidoMaternoTextField: UITextField!
    
    @IBOutlet weak var direccionTextField: UITextField!
    
    @IBOutlet weak var referidoTextField: UITextField!
    
    @IBAction func reclutarActionButton(_ sender: Any) {
        if let nombre = nombreTextField.text,
           let apellidoP = apellidoPaternoTextField.text,
           let apellidoM = apellidoMaternoTextField.text,
           let direccion = direccionTextField.text {
            
            if nombre == "" {
                // TODO: Alertar al usuario
                return
            }
            
            print("Se creará un nuevo prospecto:")
            print("\(nombre)")
            print("\(apellidoP)")
            print("\(apellidoM)")
            print("\(direccion)")
            
            let referido = referidoTextField.text
            
            if let context = prospectosModel?.viewContext {
                
                let prospecto = Prospecto(context: context)
                
                prospecto.nombre = nombre
                prospecto.apellidoPaterno = apellidoP
                prospecto.apellidoMaterno = apellidoM
                prospecto.direccion = direccion
                prospecto.referido = referido
                prospecto.estado = "RECLUTADO"
                prospecto.fechaInicio = Date.now
                prospecto.fechaActualizado = Date.now
                
                
                print("Se ha creado el prospecto en el contexto")
                
                do {
                    try context.save()
                    print("Se ha guardado el contexto")
                    //self.dismiss(animated: true)
                    self.navigationController?.popViewController(animated: true)
                } catch {
                    print("Error al intentar guardar \(error)")
                    context.rollback()
                }
                
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    

}
