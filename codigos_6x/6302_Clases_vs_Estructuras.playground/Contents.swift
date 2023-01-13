import UIKit

struct LibroData {
    
    static let shared = LibroData(autor: "Saramago", titulo: "El evangelio", año: 1994, precio: 178.56)
    
    let autor: String
    let titulo: String
    let año: Int
    var precio: Double
    
    var descripcion: String {
        "\(titulo) - \(autor) [\(año)]"
    }
    
}

class LibroEntity {
    
    // ARC + 1 => 1
    static let shared = LibroEntity(autor: "Jaramillo", titulo: "Mi música", año: 2003, precio: 134.56)
    
    let autor: String
    let titulo: String
    let año: Int
    var precio: Double
    
    var descripcion: String {
        "\(titulo) - \(autor) [\(año) $\(precio)]"
    }
    
    init(autor: String, titulo: String, año: Int, precio: Double) {
        self.autor = autor
        self.titulo = titulo
        self.año = año
        self.precio = precio
    }
    
}

var libroData1 = LibroData(autor: "Emma Watson", titulo: "Mi Lucha", año: 2022, precio: 17.99)

print(libroData1)

// COPIA LA ESTRUCTURA (ESTAMPA)
let libroData2 = libroData1

libroData1.precio = 9.99

print(libroData1)
print(libroData2)

let libroEntity1 = LibroEntity(autor: "J.K Rolling", titulo: "Harry Potter", año: 1996, precio: 54.79)

print(libroEntity1.descripcion)

// AUMENTA LA REFERENCIA (ARC +1)
let libroEntity2 = libroEntity1

libroEntity1.precio = 89.74

print(libroEntity1.descripcion)
print(libroEntity2.descripcion)

let libroD = LibroData.shared

// ARC + 1 => 2
let libroE = LibroEntity.shared

// ARC + 1 => 3
let libroE2 = LibroEntity.shared

LibroEntity.shared.precio = 0

print(LibroEntity.shared.descripcion)
print(libroE.descripcion)
print(libroE2.descripcion)
