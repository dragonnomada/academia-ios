//
//  PlatillosModel.swift
//  4502_Repaso_Combine
//
//  Created by User on 30/12/22.
//

import Foundation

///
///Establece ua entidad para almacenar o transportar datos
///
struct Platillo {
    
    let nombre: String
    let descripcion: String
    let precio: Double
}

///El modelo tiene la responsabilidad de retener los datos que vivirán en
///la aplicación, en este caso todas las plantillas necesitarán saber o interactuar
///con el platillo seleccionado.
class PlatillosModel{
    
    var platilloSeleccionado: Platillo?
}
