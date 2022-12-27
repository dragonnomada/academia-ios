import UIKit

// Grand Central Dispatch

// Concurrencia:
// Múltiples procesos se ejecutan al mismo tiempo
// utilizando estrategias de paralelización

// Concurrencia Física: Paralelo
// Cada núcleo del procesador asume tareas independientes
// * Las tareas paralelas no pueden superar el límite de CPUs
// ** Si la concurrencia alcanza el límite
//    los procesos se encolarán automáticamente

// Concurrencia Virtual: Semi-Paralelo
// Colas para ejecutar fragmetos/bloques
// de tareas indepededientes
// * Si hay muchas colas se genera un efecto de bloqueo

// DispatchQueue
// [1] Serial
// [2] Concurrent (paralelo)

// La clase DispatchQueue permite ejecutar tareas
// en forma serial y en forma concurrente
// para resolver una cola de procesos con tareas similares

// Ejemplo: Descargar múltiples archivos al mismo tiempo
// Ejemplo: Generar múltiples reportes al mismo tiempo

// Crear un despachador de tareas, serial y concurrente

// Diseñar una función intensiva que haga algún cómputo

func generarComputo(iteraciones: Int) {
    let start = Date.now.timeIntervalSince1970
    for _ in 1...iteraciones {
        // print("Esperando el cómputo... (\(i))")
        Thread.sleep(forTimeInterval: 0.5)
    }
    let end = Date.now.timeIntervalSince1970
    let diff = end - start
    print("Cómputo finalizado para \(iteraciones) en: \(diff) segundos")
}

// generarComputo(iteraciones: 3)

// [1] Despachador Serial

// El despachador serial soporta que se le mande a ejecutar una tarea
// mediante una clausura en su función `<dispatch>.async { <proceso> }`
// Al recibir el proceso lo va a guardar, es decir, lo va a encolar
// a la lista de procesos y ejecutarlo cuándo "sea su turno".
// Cómo es serial, su turno será después del anterior.

// El despachador no va a bloquear nuestro programa por los encolados.
// Esto significa que las encolaciones no bloquean el hilo principal
// Por lo que podemos mandar a encolar y continuar con el programa.

var serialDispatch = DispatchQueue(label: "Despachador serial")

print("Encolando la tarea 1")

// FIRMA: () -> Void
// serialDispatch.sync(execute: <función | clausura>)
serialDispatch.async {
    print("Inicio del dispatch 1")
    generarComputo(iteraciones: 10)
    print("Fin del dispatch 1")
}

print("Encolando la tarea 2")

serialDispatch.async {
    print("Inicio del dispatch 2")
    generarComputo(iteraciones: 20)
    print("Fin del dispatch 2")
}

print("Encolando la tarea 3")

serialDispatch.async {
    print("Inicio del dispatch 3")
    generarComputo(iteraciones: 10)
    print("Fin del dispatch 3")
}

print("Se han encolado todas las tareas")

// [2] Despachador concurrente

// El despachador concurrente soporta que se le mande a ejecutar una tarea
// mediante una clausura en su función `<dispatch>.async { <proceso> }`
// Al recibir el proceso lo va a guardar, es decir, lo va a encolar
// a la lista de procesos y ejecutarlo inmediatamente.
// Cómo es concurrente, todos los encolados estarían siendo ejecutados
// simultáneamente.

// El despachador no va a bloquear nuestro programa por los encolados.
// Esto significa que las encolaciones no bloquean el hilo principal
// Por lo que podemos mandar a encolar y continuar con el programa.

var concurrentDispatch = DispatchQueue(label: "Despachador concurrente", attributes: .concurrent)

print("[CONCURRENTE] Encolando la tarea A")

concurrentDispatch.async {
    print("[CONCURRENTE] Inicio del dispatch A")
    generarComputo(iteraciones: 10)
    print("[CONCURRENTE] Fin del dispatch A")
}

print("[CONCURRENTE] Encolando la tarea B")

concurrentDispatch.async {
    print("[CONCURRENTE] Inicio del dispatch B")
    generarComputo(iteraciones: 10)
    print("[CONCURRENTE] Fin del dispatch B")
}

print("[CONCURRENTE] Encolando la tarea C")

concurrentDispatch.async {
    print("[CONCURRENTE] Inicio del dispatch C")
    print("Hola mundo :D desde el despachador C")
    print("[CONCURRENTE] Fin del dispatch C")
}

concurrentDispatch.sync {
    print("[CONCURRENT] HOLAAAAAAAAAA")
}

print("[CONCURRENTE] Se han encolado todas las tareas")

// BlockOperation

// Podemos formalizar bloques de ejecución en forma serial
// para determinar un conjunto de operaciones o procesos
// que deban ser repetidos y ejecutados en algún momento.

// El bloque por sí mismo no ejecuta las operaciones
// y requiere de un OperationQueue para encolarlo (ejecutarlo)

var blockOperation = BlockOperation()

blockOperation.addExecutionBlock {
    print("Operación 1")
}

blockOperation.addExecutionBlock {
    print("Operación 2")
}

// OperationQueue

// Genera una cola de procesos a los que les podemos
// encolar bloques de código directo o bloques de operaciones.

var operationQueue = OperationQueue()

operationQueue.addOperation {
    print("Ejecutándo bloque de operaciones")
}

operationQueue.addOperation(blockOperation)

operationQueue.addOperation {
    print("Terminando bloque de operaciones")
}
