import UIKit
// [E21001] - Crear un protocolo llamado
// EncendibleProtocol con la propiedad encendido: Bool y
// los métodos encender() y apagar()

protocol EncendibleProtocol {
    
    var encendido: Bool { get }
    
    func encender ()
    
    func apagar ()
}

// [E21002] - Crear una clase o estructura llamada
// Lavadora que implemente la funcionalidad de
// EncendibleProtocol
struct Lavadora: EncendibleProtocol {

   let encendido: Bool { get }

  func encender () {

    encendido = true
   
  }

  func apagar () {

    encendido = false
   
  }
   
 }

// [E21003] - Crear una clase o estructura llamada Licuadora que
// implemente la funcionalidad de EncendibleProtocol a través de una
//  extensión

struct Licuadora {

  let marca: String
  let color: String
}

extension Licuadora: EncendibleProtocol {

   let encendido: Bool { get }

  func encender () {

    encendido = true
   
  }

  func apagar () {

    encendido = false
   
  }
   
 }
