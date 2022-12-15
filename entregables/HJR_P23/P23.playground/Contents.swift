/*
 Heber Eduardo Jimenez Rodriguez
 
 Creado el 14-12-22
 
 Practica 23 - Diseño Orientado a Protocolos
 */

import UIKit

//Estructura Empleado
struct Empleado {
    
    let id: String
    let nombre: String
    let sueldo: Double
    let fechaContratacion: Date
    var fechaDespido: Date?
    var activo: Bool = false
    var despedido: Bool { get { fechaDespido != nil } }
 }

//Funcion que genera fecha
func fecha_2020_01_01() -> Date {
    return DateComponents(calendar: Calendar.current, year: 2020, month: 1, day: 1).date!
}

//Funcion que genera una fecha aleatoria
func fechaAleatoria(fechaInicial: Date) -> Date {
    let segundosDesdeInicialActual = fechaInicial.timeIntervalSinceNow.magnitude
    
    let segundosAleatoriosDesdeInicial = Double.random(in: 0...segundosDesdeInicialActual)
    
    return Date(timeInterval: segundosDesdeInicialActual, since: fechaInicial)
}

//Funcion para generar una fecha para el empleado
func generarEmpleado(id: String, nombre: String) -> Empleado {
    
    let fechaContratacion = fechaAleatoria(fechaInicial: fecha_2020_01_01())
    var fechaDspido : Date? = nil
    
    if Double.random(in: 0...100) >= 90 {
        fechaDspido = fechaAleatoria(fechaInicial: fechaContratacion)
    }
    
    let empleado = Empleado(id: id, nombre: nombre, sueldo: Double.random(in: 5000...40000), fechaContratacion: fechaContratacion, fechaDespido: fechaDspido, activo: Bool.random())
    
    return empleado
}

//Se crea el arreglo empleados de tipo Empleado
var empleados: [Empleado] = []

//Se generan 10 empleados en el array empleados
for i in 1...10 {
    empleados.append(generarEmpleado(id: "\(i)", nombre: "Empleado\(i)"))
}



//Filter por empleados activos
let empleadosActivos = empleados.filter { empleado in empleado.activo }

print("---EMPLEADOS ACTIVOS---")
for empleado in empleadosActivos {
    print(empleado)
    print("-------------------------")
}

//Filter por empleados activos
let empleadosInactivos = empleados.filter { empleado in !empleado.activo }

print("---EMPLEADOS INACTIVOS---")
for empleado in empleadosInactivos {
    print(empleado)
    print("-------------------------")
}







