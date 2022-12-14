import UIKit

func partirListaEnteros(enteros: [Int]) -> (izquierda: [Int], derecha: [Int]) {
    
    var listaIzquierda : [Int] = []
    var listaDerecha : [Int] = []
    
    for (index, entero) in enteros.enumerated() {
        
        if index <= enteros.count / 2 {
            listaIzquierda.append(entero)
        } else {
            listaDerecha.append(entero)
        }
        
    }
    
    return (listaIzquierda, listaDerecha)
}

print(partirListaEnteros(enteros: [1, 2, 3, 4, 5, 6, 7, 8, 9]))

// Transformar la función a genérica

func partirLista<T>(lista: [T]) -> (izquierda: [T], derecha: [T]) {
    var listaIzquierda: [T] = []
    var listaDerecha: [T] = []
    
    for (index, elemento) in lista.enumerated() {
        if index < lista.count / 2 {
            listaIzquierda.append(elemento)
        } else {
            listaDerecha.append(elemento)
        }
    }
    
    return (listaIzquierda, listaDerecha)
}

print(partirLista(lista: ["Hola", "mundo", " mudial", "del", "universo", "universal"]))

var nums = [1, 2, 3]
