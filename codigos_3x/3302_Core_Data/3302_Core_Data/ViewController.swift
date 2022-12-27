//
//  ViewController.swift
//  3302_Core_Data
//
//  Created by User on 21/12/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    /// **PASO 3** - Importar *CoreData* y definir la variable para
    ///             que nos ajusten el `persistentContainer`
    var persistentContainer: NSPersistentContainer?
    
    @IBOutlet weak var nombreTextField: UITextField!
    
    @IBOutlet weak var precioTextField: UITextField!
    
    @IBOutlet weak var existenciasTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cargarProductos()
    }
    
    func cargarProductos() {
        
        if let context = persistentContainer?.viewContext {
            
            let requestProductos = Producto.fetchRequest()
            
            if let productos = try? context.fetch(requestProductos) {
                
                for producto in productos {
                    print("Producto: [\(producto.id)] \(producto.nombre!) $\(producto.precio) \(producto.existencias)")
                }
                
                print("-------------------------")
                
            }
            
        }
        
    }

    @IBAction func guardarAction(_ sender: Any) {
        if let context = persistentContainer?.viewContext {
            
            let producto = Producto(context: context)
            
            producto.id = Int32.random(in: 1_000...1_000_000)
            producto.nombre = nombreTextField.text
            producto.precio = Double(precioTextField.text ?? "0.0") ?? 0.0
            producto.existencias = Int32(existenciasTextField.text ?? "0") ?? 0
            
            do {
                try context.save()
                print("Producto guardado")
                nombreTextField.text = ""
                precioTextField.text = ""
                existenciasTextField.text = ""
                nombreTextField.becomeFirstResponder()
                cargarProductos()
            } catch {
                context.rollback()
                print("No se pudo guardar el producto")
            }
            
        }
    }
    
}

