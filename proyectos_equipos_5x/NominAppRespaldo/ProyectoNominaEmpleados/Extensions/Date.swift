//
//  Date.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 06/01/23.
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
