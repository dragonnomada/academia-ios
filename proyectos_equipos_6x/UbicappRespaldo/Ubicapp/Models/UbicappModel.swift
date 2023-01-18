//
// Proyecto: Ubicapp
//
// Autores:
// Joel Brayan Navor Jimenez
// Jonathan
// Heber Eduardo Jimenez Rodriguez
//
// Creado el 11 de enero del 2023
// Modificado por: Jonathan Amador el 13/01/2023
//

import Foundation
import CoreData
import Combine

class UbicappModel {
    
    // Singleton
    
    
    // Creamos el contenedor
    var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UbicappModel")
        
        // Carga todas las ubicaciones existentes en nuestro CoreData(UbicappModel)
        container.loadPersistentStores { _, error in
            if let error = error {
                // Si ocurre algun error al cargar las ubicaciones imprime este error
                fatalError("No se pudo cargar el contenedor UbicappModel")
            }
        }
        
        // Si logra cargar todas las ubicaciones, nos devuelve el contenedor
        return container
    }()
    
    // MARK: Published (Publicadores de cambios)
    // Publicador de todas las ubicaciones
    @Published var ubicaciones: [UbicacionEntity] = []
    // Ubicacion seleccionada
    @Published var ubicacionSeleccionada: UbicacionEntity?
    
    // MARK: Funciones que podemos aplicar a nuestro modelo
    // Cargar las ubicaciones desde nuestro contenedor
    func loadUbicaciones() {
        let context = self.container.viewContext
        
        let request = UbicacionEntity.fetchRequest()
        
        if let ubicaciones = try? context.fetch(request) {
            self.ubicaciones = ubicaciones
        }
    }
    
    // Seleccionar una ubicacion
    func seleccionarUbicacion(id: Int) {
        
        if let ubicacionSeleccionada = self.ubicaciones.filter({ ubicacion in
            ubicacion.id == Int32(id)
        }).first {
            
            self.ubicacionSeleccionada = ubicacionSeleccionada
            
        }
    }
    
    // Agregar una ubicacion
    func agregarUbicacion(latitud: Double, longitud: Double) {
        
        let context = self.container.viewContext
        
        let ubicacion = UbicacionEntity(context: context)
        
        
        if let ubicacionIdMaxima = self.ubicaciones.max(by: {
            ubicaion1, ubicacion2 in
            return ubicaion1.id < ubicacion2.id
        }) {
            ubicacion.id = ubicacionIdMaxima.id + 1
        } else {
            ubicacion.id = 1
        }
        
        ubicacion.latitud = latitud
        ubicacion.longitud = longitud
        ubicacion.nombre = "Anonimo"
        ubicacion.id = Int32.random(in: 1...100)
        
        do {
            try context.save()
            self.loadUbicaciones()
            self.seleccionarUbicacion(id: Int(ubicacion.id))
        } catch {
            context.rollback()
        }
    }
    
    // Actualizar una ubicacion.
    func actualizarUbicacion(nombre: String?, latitud: Double?, longitud: Double?, imagen: Data?) {
        
        if let ubicacionSeleccionada = self.ubicacionSeleccionada {
            
            if let nombre = nombre {
                ubicacionSeleccionada.nombre = nombre
            }
            
            if let latitud = latitud {
                ubicacionSeleccionada.latitud = latitud
            }
            
            if let longitud = longitud {
                ubicacionSeleccionada.longitud = longitud
            }
            if let image = imagen{
                ubicacionSeleccionada.imagen = image
            }
            
            let context = container.viewContext
            
            do {
                try context.save()
                self.loadUbicaciones()
                self.ubicacionSeleccionada = ubicacionSeleccionada
            } catch {
                context.rollback()
            }
        }
        
    }
    
    // Elimina una ubicacion seleccionada.
    func eliminarUbicacion() {
        
     /*   if let indexSeleccionado = indexSeleccionado {
            
            self.ubicaciones.remove(at: indexSeleccionado)
            self.indexSeleccionado = nil
            self.ubicacionSeleccionada = nil
            self.loadUbicaciones()
        }*/
    }
}
