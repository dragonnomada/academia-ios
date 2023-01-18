//
// Proyecto: Ubicapp
//
// Autores:
// Joel Brayan Navor Jimenez
// Jonathan
// Heber Eduardo Jimenez Rodriguez
//
// Creado el 13 de enero del 2023
//
//

import Foundation

// Definicion de vista
protocol MapaView: NSObject {
    
    // Notifica que ya tiene las ubicaciones
    func ubicacion(ubicaciones: [UbicacionEntity])
    
    // Notifica que ubicacion fue la seleccionada
    func ubicacion(ubicacionSeleccionada ubicacion: UbicacionEntity)
}
