//
//  Contador.swift
//  3406_XCTests
//
//  Created by User on 22/12/22.
//

import Foundation

class Contador {
    
    var conteo: Int = 0
    
    func incrementar() {
        self.conteo += 1
        Thread.sleep(forTimeInterval: 0.01)
    }
    
    func decrementar() {
        self.conteo -= 1
    }
    
}
