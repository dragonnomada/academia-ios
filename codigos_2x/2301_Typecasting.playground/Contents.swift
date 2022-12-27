import UIKit

// Typecasting se refiere a la conversión de tipos

// En clases:

// Cada clase define un nuevo TIPO
// Por ejemplo, class Maquina -> Maquina

// Al hacer herencia un TIPO se puede comportar en otro
// por ejemplo, una clase derivada se puede comportar como una clase base

// a = A()
// a.foo()
class A {
    func foo() {
        print("Hola soy foo de la clase A")
    }
}

// B <- A
// b = B()
// b.foo()
// b.goo()
class B: A {
    func goo() {
        print("Hola soy goo de la clase B")
    }
}

var arregloDeAs : [A] = []

// ¿Quiénes se comportan como A?
// Respuesta: A y todos sus derivados (incluyendo B)

arregloDeAs.append(A())
arregloDeAs.append(B())
arregloDeAs.append(B())
arregloDeAs.append(A())
arregloDeAs.append(A())
arregloDeAs.append(B())
arregloDeAs.append(A())

// Si recorremos los elementos del arreglo [A],
// ¿Qué tipo son?

// ¿De qué tipo es x?
// x : A
// x.foo()
for x in arregloDeAs {
    x.foo() // x es de tipo A y sólo puede llamar a foo()
    // aunque algunas x'ses provengan de instancias de B
    // están limitadas a ser del tipo A
    
    // ¿Cómo podemos acceder o saber quiénes son de tipo B?
    // x as? B significa "x se puede castear como B"
    // en español: "¿Podemos convertir x a la clase B?"
    // entonces b sería una instancia de la clase B
    // a esto se le conoce como `Typecasting`
    if let b = x as? B {
        b.foo()
        b.goo()
    }
    
    if x is B {
        x.foo()
        (x as! B).goo()
    }
}

// Analogía:
// En un evento familiar el abuelo los invita a una ceremonia,
// pero todos deben actuar como el abuelo, entonces todos miembros
// de la familia se limitan a actuar según les enseñó el abuelo
// Si al algún miembro quiere actuar bajo su propia naturaleza
// deberá castearse (reconvertirse) a su propio tipo
// Es decir, debería transformarse del tipo abuelo (como viejito)
// a su propio tipo y así recuperar su naturaleza

// Existe un operador where que nos simplica filtrar los elementos
// pero no hace el `Typecasting`

for x in arregloDeAs where x is B {
    let b = x as! B
    b.foo()
    b.goo()
    
    // (x as! B).goo()
}
