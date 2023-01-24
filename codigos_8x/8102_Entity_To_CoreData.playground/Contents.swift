import UIKit
import CoreData

struct FrutaEntity {
    
    let id: Int
    let nombre: String
    let cantidad: Double
    
}

struct CanastaFrutaEntity {
    
    let id: Int
    let nombre: String
    let frutas: [FrutaEntity]
    
}

let fruta1 = FrutaEntity(id: 1, nombre: "Manzana", cantidad: 18.59)
let fruta2 = FrutaEntity(id: 2, nombre: "Pera", cantidad: 17.63)
let fruta3 = FrutaEntity(id: 3, nombre: "Mango", cantidad: 48.17)

let canasta1 = CanastaFrutaEntity(id: 1, nombre: "Lunes", frutas: [fruta1, fruta2])

let canasta2 = CanastaFrutaEntity(id: 2, nombre: "Martes", frutas: [fruta3])

let container = NSPersistentContainer(name: <#T##String#>)
