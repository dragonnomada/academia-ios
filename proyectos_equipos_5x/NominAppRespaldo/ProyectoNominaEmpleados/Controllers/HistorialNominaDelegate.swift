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

protocol HistorialNominaDelegate {

    func pago(historialPagos historial: [PagoEntity])
    
    func pago(pagoSeleccionado: PagoEntity, index: Int)
}
