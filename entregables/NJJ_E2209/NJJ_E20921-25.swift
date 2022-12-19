/*
Joel Brayan Navor Jimenez
    [E20921] - Diseñar un protocolo DescribibleProtocol que tenga el método describir() -> String

    [E20922] - Diseñar una clase Automovil que sea DescribibleProtocol

    [E20923] - Diseñar una estructura Libro que sea describible, considerando unir las propiedades autor: String, titulo: String y año: Int.

    [E20924] - Diseñar una clase Moto derivada de Automóvil sin modificar el método describir.

    [E20925] - Crear un Automovil, una Moto y un Libro en un arreglo del tipo DescribibleProtocol y mandar a describir a cada uno.

*/

import Foundation

protocol DescribibleProtocol {
    func describir() -> String


}

class Automovil: DescribibleProtocol {
    let id: Int
    let año: Int
    let marca: String
    
    init(id: Int, año: Int, marca: String) {
        self.id = id
        self.marca = marca
        self.año = año
    }
    
    func describir() -> String {
        return "Descripción del automovil, Año: \(año), Marca: \(marca)"
    }

struct Libro: DescribibleProtocol{
    let autor: String
    let titulo: String
    let año: Int

    func describir() -> String {
        return "Autor: (\(autor), Año: \(año), Titulo: \(titulo))"
    }
}
class Moto: Automovil {
    
    final override func describir() -> String {
        return "Descripcion Moto, id: \(id), marca: \(marca)"
    }
    
}
    let describible : [DescribibleProtocol] = [Libro(autor: "Lucio", titulo: "Los ojos de mi princesa", año: 2009), Moto(id: 1, año: 2, marca: "Susuki"), Automovil(id: 2, año: 2, marca: "Tesla")]

    func describir(describible: DescribibleProtocol) {
        print(describible)
    }
}
