import UIKit

struct Empleado {
    let id: String
    let nombre: String
    let sueldo: Double
    let fechaContratacion: Date
    var fechaDespido: Date?
    let activo: Bool
    var despedido: Bool { get { fechaDespido != nil } }
     
    public var description: String {
        get {
            let formato = DateFormatter()
            formato.locale = Locale(identifier: "ES")
            formato.setLocalizedDateFormatFromTemplate("YYYY/MM/dd")
            return """
                    [\(id)] \(nombre)
                    SUELDO: $\(sueldo)
                    CONTRATADO: \(formato.string(from: fechaContratacion))
                    DESPEDIDO: \(despedido ? formato.string(from: fechaDespido!) : "-")
                    ACTIVO: \(activo)
                   """
        }
    }
}

func fecha_2020_01_01() -> Date {
    return DateComponents(calendar: Calendar.current, year: 2020, month: 1, day: 1).date!
}

func fechaAleatoria(fechaInicial: Date) -> Date {
    let segundosDesdeIncialActual = fechaInicial.timeIntervalSinceNow.magnitude

    let segundosAleatoriosDesdeInicial = Double.random(in: 0...segundosDesdeIncialActual)

    return Date(timeInterval: segundosAleatoriosDesdeInicial, since: fechaInicial)
}

func generaEmpleadoAleatorio(id: String, nombre: String) -> Empleado {
    
    let fechaContratacion = fechaAleatoria(fechaInicial: fecha_2020_01_01())
    var fechaDespido : Date? = nil
    
    if Double.random(in: 0...100) >= 90  {
        fechaDespido = fechaAleatoria(fechaInicial: fechaContratacion)
    }
    
    let empleado = Empleado(id: id, nombre: nombre, sueldo: Double.random(in: 5_000...40_000), fechaContratacion: fechaContratacion, fechaDespido: fechaDespido, activo: Bool.random())
    return empleado
}

var empleados: [Empleado] = []

for i in 1...10 {
    empleados.append(generaEmpleadoAleatorio(id: "e\(i)", nombre: "Empleado \(i)"))
}

print(empleados)

// FIRMA: empleados.filter(_ isIncluded: (Empleado) -> Bool) -> [Empleado]
let empleadosActivos = empleados.filter { empleado in empleado.activo }

print("=== EMPLEADOS ACTIVOS ===")
for empleado in empleadosActivos {
    print(empleado.description)
    print("-------------------------")
}
print("=========================")

let empleadosInactivos = empleados.filter { empleado in !empleado.activo }

print("=== EMPLEADOS INACTIVOS ===")
for empleado in empleadosInactivos {
    print(empleado.description)
    print("-------------------------")
}
print("=========================")
