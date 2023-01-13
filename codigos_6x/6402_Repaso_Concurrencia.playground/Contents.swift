import UIKit
import Darwin

// THREAD: main

/*

print(Date.now)

print("Creando y ejecutándo hilos (síncrono y asíncrono)")

// El hilo se ejecuta (libre) [SERIAL]
let mySyncThread = DispatchQueue(label: "Mi Hilo 1 (Síncrono)")

// El hilo se ejecuta (libre) [CONCURRENTE]
let myAsyncThread = DispatchQueue(label: "Mi Hilo 2 (Asíncrono)", attributes: .concurrent)

// El hilo registra una nueva tarea y la encola
// para ejecutarse si el hilo está libre
mySyncThread.sync {
    print("[\(Thread.current.description)] Hola 1")
    Thread.sleep(forTimeInterval: 4)
}

// El hilo registra una nueva tarea y la encola
// para ejecutarse si el hilo está libre
mySyncThread.sync {
    print("[\(Thread.current.description)] Hola 2")
    Thread.sleep(forTimeInterval: 3)
}

// El hilo registra una nueva tarea y la encola
// para ejecutarse si el hilo está libre
mySyncThread.sync {
    print("[\(Thread.current.description)] Hola 3")
    Thread.sleep(forTimeInterval: 5)
}

print("Terminé de ejecutar el hilo síncrono") // 12.0000

print(Date.now)

myAsyncThread.async {
    Thread.sleep(forTimeInterval: 4)
    print("[\(Thread.current.description)] Hello 1")
}

myAsyncThread.async {
    Thread.sleep(forTimeInterval: 3)
    print("[\(Thread.current.description)] Hello 2")
}

myAsyncThread.async {
    Thread.sleep(forTimeInterval: 5)
    print("[\(Thread.current.description)] Hello 3")
}

print("Terminé de ejecutar el hilo asíncrono") // 12.0001

print(Date.now)

*/

func task(duration: TimeInterval, complete: @escaping (Int) -> Void) {
    
    DispatchQueue(label: "NUEVO_HILO").async {
        print("[\(Thread.current.description)] Hola mundo")
    }
    
    let asyncQueue = DispatchQueue(label: "TASK", attributes: .concurrent)
    
    // THREAD: main
    
    asyncQueue.async {
        // THREAD: task
        
        print("0.0002 [\(Thread.current.description)] Ejecutándo tarea") // 0.0002
        
        // THREAD: task
        
        Thread.sleep(forTimeInterval: duration) // 0.0003
        
        print("5.0003 [\(Thread.current.description)] Han pasado \(duration) segundos") // 5.0003
        
        complete(Int.random(in: 1...100)) // 5.0004
        
        print("5.0005 [\(Thread.current.description)] Ha finalizado la tarea") // 5.0005
    }
    
}

// THREAD: main

print("0.0000 [\(Thread.current.description)] Voy a ejecutar la tarea") // 0.0000

func completado(valor: Int) {
    // THREAD: task
    
    print("5.0005 [\(Thread.current.description)] Se ha completado la tarea") // 5.0005
}

// THREAD: main

task(duration: 5.0, complete: completado) // 0.0001

// THREAD: main

print("0.0002 [\(Thread.current.description)] Tarea se mandó a ejecutar") // 0.0002

// THREAD: main

// CONCLUSIONES:
// * Las funciones que reciben otras funciones podrían escaparnos de nuestro hilo. Nos advertirán que son de tipo @escaping
// * Al estar en otro hilo, podríamos dañar el funcionamiento normal de nuestra aplicación
// * Por ejemplo, al consumir un API salimos de nuestro hilo y nos ejecutámos en el hilo del URLSession.dataTask
// * Debemos evitar crear referencias auto-capturadas por dichas clausuras, especialmente de `self`
