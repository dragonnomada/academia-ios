/*
 Joel Brayan Navor Jimenez (joelnavorjimenez@gmail.com)
  Creado el 14 de Diciembre de 2022
  Practica 23 -
*/
import UIKit
//1. Creaciòn de la estructura Empleado
struct Empleado {
    
    let id: String
    let nombre: String
    let sueldo: Double
    var fechaContratacion: Date
    var fechaDespido: Date?
    var activo: Bool = true
    var despedido: Bool {  get { fechaDespido != nil }  }
    //Descripciòn para mostrar los datos de mis empleados
    public var description: String {
        //Obtengo los datos de mi empleado
        get {
         let formato = DateFormatter()
         formato.locale = Locale(identifier: "ES")
         formato.setLocalizedDateFormatFromTemplate("YYYY/MM/dd")
         
            return """
                [\(id)] \(nombre)
                SUELDO: $\(sueldo)
                Contratado \(formato.string(from: fechaContratacion))
                Despedido \(despedido ? formato.string(from: fechaDespido!) : "-")
                ACTIVO: \(activo)
                """
        }
    }
    
}

//Creacion del arreglo empleados
var empleados: [Empleado] = []
//Funcion encargada de proporcionar fechas aleatorias a partir del 2020
func fechaAleatoria(fechaInicial: Date) -> Date {
    //Definicion de la fecha inicial
    //let fechaInicial = DateComponents(calendar: Calendar.current, year: 2020, month: 1, day: 1).date!
    //contador de segundos desde la fecha inicial
    let segundosDesdeIncialActual = fechaInicial.timeIntervalSinceNow.magnitude
    // Randomizo mis segundos por algunos aleatorios
    let segundosAleatoriosDesdeInicial = Double.random(in: 0...segundosDesdeIncialActual)
    // Segundos aleatorios
    let fechaAleatoria = Date(timeInterval: segundosAleatoriosDesdeInicial, since: fechaInicial)
    //Retorno la fecha Inicial
    return fechaAleatoria
}
//Funcion que pasa la fecha actual
func fecha_2020_01_01() -> Date {
    return DateComponents(calendar: Calendar.current, year: 2020, month: 1, day: 1).date!
}

//Funcion que regresa una fecha aleatoria en base al algoritmo anterior
func fechaDespidoAleatoria() -> Date {
    let fechaInicial = DateComponents(calendar: Calendar.current, year: 2020, month: 1, day: 1).date!
    let segundosDesdeIncialActual = fechaInicial.timeIntervalSinceNow.magnitude
    
    let segundosAleatoriosDesdeInicial = Double.random(in: 0...segundosDesdeIncialActual)
    
    let fechaAleatoria = Date(timeInterval: segundosAleatoriosDesdeInicial, since: fechaInicial)
    
    return fechaAleatoria
}
func generaEmpleadoAleatorio ( id: String, nombre: String ) -> Empleado{
    
    let fechaContratacion = fechaAleatoria(fechaInicial: fecha_2020_01_01())
    var fechaDespido : Date? = nil
    
    if Double.random(in: 0...100) >= 90 {
        fechaDespido = fechaDespidoAleatoria()
    }
    let empleado1 = Empleado(id: id, nombre: nombre, sueldo: Double.random(in: 5_000...40_000), fechaContratacion: fechaContratacion, fechaDespido: fechaDespido, activo: Bool.random())
    return empleado1
}

//Funcion que regresa un sueldo aleatorio
func sueldoAleatorio() -> Double {
    return Double.random(in: 5_000...40_000)
}
//Funcion encargada de generar un nombre aleatorio
func nombreAleatorio() -> String {
    var num = Int.random(in: 1...1000)
    return "Empleado: \(num)"
}



//Bucle for encargado de generar mil empleados
for i in 1...1000{
    
    empleados.append(generaEmpleadoAleatorio(id: "\(i)", nombre: "Empleado\(i)"))
}
//Bucle for para agregar los empleados
for empleado in empleados {
    print(empleado)
    print("-------")
}
//Funcion filter para filtrar mis empleados activos
let empleadosActivos = empleados.filter{ empleado in empleado.activo }
print("-----Empleados Activos-----")
//For each para cada empleado que cumpla con el filtro (filter)
empleadosActivos.forEach { empleado in print(empleado.description) }
print("----------------------------")
print("-----Empleados Inactivos-----")
//Filtro para cada empleado que no este activo
let empleadosInactivos = empleados.filter { empleado in !empleado.activo }
print("------------------------------")




