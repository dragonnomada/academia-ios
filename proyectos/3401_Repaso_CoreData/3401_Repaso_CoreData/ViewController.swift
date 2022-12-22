//
//  ViewController.swift
//  3401_Repaso_CoreData
//
//  Created by User on 22/12/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var contadorLabel: UILabel!
    
    var appModel: NSPersistentContainer?
    
    var contador: Contador?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let context = appModel?.viewContext {
            if let contador = try? context.fetch(Contador.fetchRequest()).first {
                self.contador = contador
                contadorLabel.text = "\(contador.conteo)"
            } else {
                self.contador = Contador(context: context)
            }
        }
        
    }

    @IBAction func incrementarAction(_ sender: Any) {
        print("Incrementando")
        if let contador = contador {
            contador.conteo += 1
            contadorLabel.text = "\(contador.conteo)"
            /// Guardamos el **contexto**
            /// Todos los cambios realizados a los objetos almacenados
            /// nuevos o existentes son guardados
            if let context = appModel?.viewContext {
                do {
                    try context.save()
                } catch {
                    context.rollback()
                }
            }
        }
    }
    
}

