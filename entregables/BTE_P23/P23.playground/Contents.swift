import UIKit

// Configuramos los valores de formato para nuestra salida de Fecha
let formato = DateFormatter()
formato.locale = Locale(identifier: "ES")
formato.setLocalizedDateFormatFromTemplate("YYYY/MMM/dd")

struct Empleado {
    let id: String
    let nombre: String
    let sueldo: Double
    let fechaContratacion: Date
    var fechaDespido: Date?
    let activo: Bool
    var despedido: Bool  { get { fechaDespido != nil } }
    
    func describir() {
        print("---------- Emplado: \(self.id) ------------")
        print("Nombre: \(self.nombre)")
        print("Sueldo: \(self.sueldo)")
        print("Fecha Contratación: \(formato.string(from: self.fechaContratacion))")
        let estado = activo ? "Activo": "Inactivo"
        print("Estado Laboral: \(estado)")
        if let _fechaDespido = fechaDespido {
            print("Fecha Despido: \(formato.string(from: _fechaDespido))")
        }
    }
}

var empleados : [Empleado] = []



func fechaInicialAleatoria() -> Date {
    
    let fechaInicial = DateComponents(calendar: Calendar.current, year: 2020, month: 1, day: 1).date!
    let segundosDesdeIncialActual = fechaInicial.timeIntervalSinceNow.magnitude
    let segundosAleatoriosDesdeInicial = Double.random(in: 0...segundosDesdeIncialActual)
    let fechaAleatoria = Date(timeInterval: segundosAleatoriosDesdeInicial, since: fechaInicial)
    
    return fechaAleatoria
}

func fechaDespidoAleatorio(fechaInicial: Date) -> Date {
    let fechaInicial = fechaInicial
    let segundosDesdeIncialActual = fechaInicial.timeIntervalSinceNow.magnitude
    let segundosAleatoriosDesdeInicial = Double.random(in: 0...segundosDesdeIncialActual)
    let fechaAleatoria = Date(timeInterval: segundosAleatoriosDesdeInicial, since: fechaInicial)
    
    return fechaAleatoria
    
}

func salarioAleatorio() -> Double {
    return Double.random(in: 5_000...40_000).rounded()
}

func nombreAleatorio() -> String {
    return "Eduardo"
}

for i in 1...100{
   // var empleado = Empleado(id: "\(i)", nombre: "Eduardo \(i)", sueldo: salarioAleatorio(), fechaContratacion: fechaInicialAleatoria(), )
    
    var empleado = Empleado(id: "\(i)", nombre: nombreAleatorio(), sueldo: salarioAleatorio(), fechaContratacion: fechaInicialAleatoria(), activo: Int.random(in: 0...100) > 50)
    
    if Int.random(in: 0...100) >= 90 {
        empleado.fechaDespido = fechaDespidoAleatorio(fechaInicial: empleado.fechaContratacion)
    }
    empleados.append(empleado)
    
}

//for empleado in empleados {
//    print(empleado.describir())
//}

//Los empleados activos e inactivos tiene la empresa
let empleadosActivos = empleados.filter { empleado in empleado.activo}

print("======= EMPLEADOS ACTIVOS =======")
for empleado in empleadosActivos {
    print(empleado.describir())
    print("----------------------------------")
}
print("==================================")
print("")
//Los empleados ganan más de $20,000 en sueldo base

let empleadosMayores_20_000 = empleados.filter { empleado in
    empleado.sueldo > 20_000
}
print("======= EMPLEADOS MAYORES a 20,000 =======")
for empleado in empleadosMayores_20_000 {
    print(empleado.describir())
    print("----------------------------------")
}
print("==================================")
print("")
//Los empleados contratados este año
let empleadosContratadosEsteAño = empleados.filter { empleado in
    let esteAño = DateComponents(calendar: Calendar.current, year: 2022, month: 1, day: 1).date!
    return empleado.fechaContratacion > esteAño
}
print("======= EMPLEADOS CONTRATADOS ESTE AÑO =======")
for empleado in empleadosContratadosEsteAño {
    print(empleado.describir())
    print("----------------------------------")
}
print("==================================")
print("")
//Los empleados despedidos el año anterior
let empleadosDespedidosEsteAño = empleados.filter { empleado in
    let añoAnterior = DateComponents(calendar: Calendar.current, year: 2021, month: 1, day: 1).date!
    let esteAño = DateComponents(calendar: Calendar.current, year: 2022, month: 1, day: 1).date!
    guard let fechaDespido = empleado.fechaDespido else {
        return false
    }
    return fechaDespido > añoAnterior && fechaDespido < esteAño
}
print("======= EMPLEADOS DESPEDIDOS EL AÑO PASADO =======")
for empleado in empleadosDespedidosEsteAño {
    print(empleado.describir())
    print("----------------------------------")
}
print("==================================")
print("")

