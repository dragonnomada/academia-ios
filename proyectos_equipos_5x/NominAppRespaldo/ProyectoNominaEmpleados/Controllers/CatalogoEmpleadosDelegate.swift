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

protocol CatalogoEmpleadosDelegate {

    func empleado(empleadosCargados empleados: [EmpleadoEntity])
    func empleado(empleadoCreado empleado: EmpleadoEntity)
    func empleado(empleadoCreadoError message: String)
    func empleado(empleadoSeleccionado empleado: EmpleadoEntity, index: Int)
}
