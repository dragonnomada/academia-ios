//
//  ViewController.swift
//  4401_Repaso_CoreData
//
//  Created by User on 29/12/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    ///**PASO 2** - Preparar a la vista para recibir el contenedor persistente
    var appPersistentContainer: NSPersistentContainer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///**PASO 4** - Utilizar el contenedor
        ///
        ///Los contenedores son consumidos a través de su contexto el cual es un administrador
        ///de objetos persistentes generados por medio de las entidades definidas en el modelo
        ///(´AppModel´)
        ///
        ///El contexto del contenedor puede aplicar las siguientes operaciones:
        ///
        ///* **fetch()** - Recuperamos objetos persistentes del contenedor
        ///* **save()** - Guardamos objetos persistentes nuevos y modificados hacia el contenedor
        ///* **delete ()** - Elimina objetos persistentes sobre el contenedor
        ///
        
        if let context = appPersistentContainer?.viewContext {
            
            //Vamos a crear un nuevo ´DemoEntity´cada que la aplicación cargue
            //y vamos a guardar el contexto
            
            ///Crear un nuevo objeto persistente de la entidad ´DemoEntity´en el contexto
            let demo = DemoEntity(context: context)
            
            demo.id = Int64.random(in: 1...1_000_000)
            demo.nombre = "Demo \(demo.id)"
            demo.pulsado = Bool.random()
            
            //En este momento hay una nueva entidad en el contexto, pero el
            //contexto no ha sido guardado. Debemos guardar el contexto para
            //que todo lo ocurrido sea persistente.
            
            do {
                // Intentamos guardar el contexto
                try context.save()
                print("Se guardó el contexto exitosamente")
            } catch {
                // Descartamos los cambios sobre el contexto
                context.rollback()
                print("Se descartaron los cambios al contexto. Error: \(error)")
            }
            
            //Vamos a recuperar todos los objetos persistentes
            //vamos a recuperar la lista (arreglo) de objetos persistentes
            //de la entidad ´DemoEntity´
            
            //1. Hacer una petición de objetos persistentes
            let request = DemoEntity.fetchRequest()
            
            //2. Solicitarle al contexto los objetos persistentes
            //   que cumplan la petición
            //Nota: Intentamos opcionalmente recuperarlos si es posible
            if let demos = try? context.fetch(request) {
                //demos: [DemoEntity]
                demos.forEach {
                    demo in
                    print("[\(demo.id)] \(demo.nombre ?? "SIN NOMBRE") (\(demo.pulsado ? "PULSADO" : "SIN PULSAR"))")
                }
            }
            
        }
    }


}

