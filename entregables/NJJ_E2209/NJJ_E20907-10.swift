/*
Joel Brayan Navor Jimenez

    [E20907] - Crear una estructura con propiedades almacenadas para retener los valores de una cafetera

    [E20908] - Agregar una propiedad computada que diga en un Bool si la cafetera está vacía en café y otra vacía en agua

    [E20909] - Crear un observador para la propiedad capacidadAgua y capacidadCafe para impedir que superen ciertos límites o se llegue a negativos

    [E20910] - Crear un observador para la propiedad capaciadAgua que impida asignar más de 100ml respecto al valor anterior.

*/

import Foundation

struct Cafetera {
    //Variables retención de datos
    let capacidadAgua: Int = 1200 
    let capacidadCafe: Int = 1200
    var nuevoContenidoAgua: Int = 0
    var nuevoContenidoCafe: Int = 0
    var contenidoAgua: Int = 0 { 
         willSet(nuevocontenidoAgua) {
             if nuevocontenidoAgua < 0  {
                  fatalError() 
        }
     } 
        didSet(contenidoAgua) { 
            if nuevoContenidoAgua > contenidoAgua + 100 { 
                  fatalError() 
                  } 
        } 
    } 

    var contenidoCafe: Int = 0 { 
        willSet(contenidoCafe) { 
            if contenidoCafe < 0 { 
                 fatalError() 
                 } 
        } 
    }

    //Propiedades Computadas
    var vacioAGua: Bool {
        get { self.contenidoAgua == 0 }
    }
    var vacioCafe: Bool {
        get { self.contenidoCafe == 0 }
    }
    
    
    

}

