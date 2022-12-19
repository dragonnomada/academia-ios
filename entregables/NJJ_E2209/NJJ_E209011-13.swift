/*
    Joel Brayan Navor Jimenez
    
    [E20911*] - Crear una clase para un robot móvil en 2D que tenga una coordenada x entera y una coordena y entera, con los métodos para mover al norte, al sur, al este y al oeste. Nota: Sin valores por defecto o inicializadores no podremos definir la clase.

    [E20912] - Agrega un inicializador para recibir la x y la y

    [E20913] - Provocar un fallo si las coordenadas son negativas
*/

import Foundation

class Robot2D {

    var coordenadaX: Int 
    var coordenadaY: Int 

    init?(coordenadaY: Int, coordenadaX: Int ){
        self.coordenadaX = coordenadaX
        self.coordenadaY = coordenadaY
        if (coordenadaX < 0) {
            return nil
        }
        if (coordenadaY < 0) {
            return nil
        }
    }
    
    func moverNorte() -> Int{ 
        coordenadaY += 1
        return coordenadaY
     }
    func moverSur() -> Int{ 
        coordenadaY -= 1
        return coordenadaY
     }
    func moverEste() -> Int{ 
        coordenadaX += 1
        return coordenadaX
     }
    func moverOeste() -> Int{ 
        coordenadaX -= 1
        return coordenadaX
     }



}