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

protocol SeleccionarVacacionesDelegate {

    func empleado(fechaSeleccionada fecha: Date, tipoFecha tipo: TipoFecha)
}
