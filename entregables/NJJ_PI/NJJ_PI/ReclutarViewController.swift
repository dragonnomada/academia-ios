//
//  ReclutarViewController.swift
//  NJJ_PI
//  Joel Brayan Navor Jimenez (joelnavorjimenez@gmail.com)
//  Trabajo Creado el 27/12/22.
//  Proyecto Individual ReclutaApp
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
            
            /// Comprobación por si existen campos vacios
            if nombre == "" {
                /// Creación de la alerta para avisar al usuario
                let alert = UIAlertController(title: "No se pudo guardar", message: "El nombre es requerido", preferredStyle: .alert)
                alert.addAction (
                    UIAlertAction(title: "Aceptar", style: .default)
                    
                )
                /// Exposicion de la alerta
                self.present(alert, animated: true)
                return
            }
            
            /// Comprobación por si existen campos vacios
            if apellidoP == "" {
                /// Creación de la alerta para advertir al usuario
                let alert = UIAlertController(title: "No se pudo guardar", message: "El apellido es requerido", preferredStyle: .alert)
                alert.addAction (
                    UIAlertAction(title: "Aceptar", style: .default)
                    
                )
                /// Exposición de la alerta
                self.present(alert, animated: true)
                return
            }
            
            /// Comprobación por si existen campos vacios
            if apellidoM == "" {
                /// Creación de la alerta para advertir al usuario
                let alert = UIAlertController(title: "No se pudo guardar", message: "El apellido es requerido", preferredStyle: .alert)
                alert.addAction (
                    UIAlertAction(title: "Aceptar", style: .default)
                    
                )
                self.present(alert, animated: true)
                return
            }
            
            if direccion == "" {
                /// Creación de la alerta para advertir al usuario
                let alert = UIAlertController(title: "No se pudo guardar", message: "La dirección es requerida", preferredStyle: .alert)
                alert.addAction (
                    UIAlertAction(title: "Aceptar", style: .default)
                    
                )
                self.present(alert, animated: true)
                return
            }
            
            print("Se creará un nuevo prospecto:")
            print("\(nombre)")
            print("\(apellidoP)")
            print("\(apellidoM)")
            print("\(direccion)")
            /// Asignación del referido contenido en el textfield
            let referido = referidoTextField.text
            /// Creación del contexto igual a prospectos model
            if let context = prospectosModel?.viewContext {
                /// Creación del prospecto al que le asiganaremos los datos.
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
                /// Tratamos de guardar el contexto
                do {
                    try context.save()
                    print("Se ha guardado el contexto")
                    
                    self.navigationController?.popViewController(animated: true)
                /// Si resulta en error informamos al usuario del error 
                } catch {
                    print("Error al intentar guardar \(error)")
                    context.rollback()
                }
                
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

}
