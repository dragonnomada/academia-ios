import UIKit

let fecha = Date()

let formato = DateFormatter()

formato.locale = Locale(identifier: "ES")
formato.setLocalizedDateFormatFromTemplate("YYYY/MMM/dd")

//formato.dateStyle = .full

print(formato.string(from: fecha))

let fecha1 = DateComponents(calendar: Calendar.current, year: 2022, month: 5, day: 28).date!

print(formato.string(from: fecha1))

print(fecha1 < fecha)

print(fecha1 > fecha)

let fechaInicial = DateComponents(calendar: Calendar.current, year: 2020, month: 1, day: 1).date!

let segundosDesdeIncialActual = fechaInicial.timeIntervalSinceNow.magnitude

print(segundosDesdeIncialActual)

let segundosAleatoriosDesdeInicial = Double.random(in: 0...segundosDesdeIncialActual)

print(segundosAleatoriosDesdeInicial)

let fechaAleatoria = Date(timeInterval: segundosAleatoriosDesdeInicial, since: fechaInicial)

print(formato.string(from: fechaAleatoria))
