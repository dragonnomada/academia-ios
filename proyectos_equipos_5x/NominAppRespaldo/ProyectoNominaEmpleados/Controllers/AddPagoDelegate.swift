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

protocol AddPagoDelegate {

    func salario(salarioCreado salario: PagoEntity)
    func salario(salarioCreadoError message: String)
    func salario(fechaPago fecha: Date, tipoFech tipo: TipoFecha)
}
