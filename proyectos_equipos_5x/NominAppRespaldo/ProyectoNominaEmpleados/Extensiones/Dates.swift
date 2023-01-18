//
// Proyecto: NominApp
//
// Autores:
// Joel Brayan Navor Jimenez
// Brian Jimenez Moedano
// Heber Eduardo Jimenez Rodriguez
//
// Creado el 6 de enero del 2023
//
import Foundation

extension Date {
    
    var toString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_MX")
        formatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
        return formatter.string(from: self)
    }
    
}

extension Int {
    
    var toString: String { "\(self)" }
    
}

extension Int32 {
    
    var toString: String { "\(self)" }
    
}

extension Double {
    
    var toString: String { "\(self)" }
    var toCurrency: String { "$\(self)" }
    
}
