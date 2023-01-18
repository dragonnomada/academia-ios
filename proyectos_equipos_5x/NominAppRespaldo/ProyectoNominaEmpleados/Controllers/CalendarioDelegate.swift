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

protocol CalendarioDelegate {

    func empleado(fechaSeleccionada fecha: Date)
    func empleado(fechaSeleccionadaError message: String)
}
