//
//  ViewController.swift
//  4401_repaso_CoreData
//
//  Created by MacBook  on 29/12/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    /// 2 PREPARARA ALA VISTA PARA RESIVIR EL CONTENEDOR PERSISTENTE

    var AppPersistentCantainer: NSPersistentContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // paso 4 utilizar el contenedor
        
        ///los contenedores son consumido atraves de sui contexto el cual es un administrado
        
        
        ///*FETCH()*
        ///*save()*
        ///**delete()**
        if let contexto = AppPersistentCantainer?.viewContext{
            // vamos a creara un nuevo demo DEMOEMTITY cada que la aplicacion
            ///crear un nuevo objeto persistente de la entidad DemoEmtity en el contexto
            let demo = DemoEntity(context: contexto)
            
            demo.id = Int32.random(in: 1...1_000_000)
            demo.nombre = "demo \(demo.id)"
            demo.pulsado = Bool.random()
            
            do {
                try contexto.save()
                print("se gaurdo el contexto exitosamente")
            }catch{
                contexto.rollback()
                print("se descartaron los cambios al contexto error: \(error)")
            }
            
            
            
            /// vamos a recuperar los arreglos de objetos persistentes
            /// 1. hacer una peticion de objetos persistentes
            let request = DemoEntity.fetchRequest()
            /// solicitarle al contexto
            if let demos = try? contexto.fetch(request){
                ///demos es de tipo [demoEntity]
                demos.forEach { demo in
                    
                    print(" [\(demo.id)] \(demo.nombre ?? "SIN NOMBRE") (\(demo.pulsado ? "pulsado" : "sin pulsar")")
                }
            }
        }
        
    }


}

