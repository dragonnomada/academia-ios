//
// Proyecto: NominApp
//
// Autores:
// Joel Brayan Navor Jimenez
// Brian Jimenez Moedano
// Heber Eduardo Jimenez Rodriguez
//
// Creado el 5 de enero del 2023
//

import Foundation

protocol DetallesEmpleadoDelegate {

    func empleado(empleadoSeleccionado empleado: EmpleadoEntity)
    func empleado(vacacionesSeleccionadas vacaciones: Date, tipoFecha tipo: TipoFecha)
}
