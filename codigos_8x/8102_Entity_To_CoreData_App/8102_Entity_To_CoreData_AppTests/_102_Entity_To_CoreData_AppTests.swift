//
//  _102_Entity_To_CoreData_AppTests.swift
//  8102_Entity_To_CoreData_AppTests
//
//  Created by MacBook  on 23/01/23.
//

import XCTest
import Combine
@testable import _102_Entity_To_CoreData_App

final class _102_Entity_To_CoreData_AppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    var canastaCreadaSubscriber: AnyCancellable?
    var canastaSeleccionadaSubscriber: AnyCancellable?
    
    func testFrutasService() {
        
        let service = CanastaFrutasService()
        
        canastaSeleccionadaSubscriber = service.canastaSeleccionadaSubject.sink {
            
            canasta in
            
            print("Canasta seleccionada: \(canasta)")
            
            if canasta.frutas.isEmpty {
                service.agregarFrutaCanastaSeleccionada(nombre: "Manzana", cantidad: 12.5)
                service.agregarFrutaCanastaSeleccionada(nombre: "Pera", cantidad: 13.5)
                service.agregarFrutaCanastaSeleccionada(nombre: "Mango", cantidad: 2.5)
                service.agregarFrutaCanastaSeleccionada(nombre: "Pila", cantidad: 4.5)
                service.seleccionarCanasta(id: canasta.id)
                return
            }
            
            for fruta in canasta.frutas {
                print("[\(fruta.id)] \(fruta.nombre) [Cantidad: \(fruta.cantidad) kg]")
            }
            
        }
        
        canastaCreadaSubscriber = service.canastaCreadaSubject.sink {
            
            canasta in
            
            print("Canasta creada: \(canasta)")
            
            service.seleccionarCanasta(id: canasta.id)
            
        }
        
        service.debugCanastas()
        
        service.crearCanasta(nombre: "Canasta aleatoria \(Int.random(in: 1...Int.max))")
        
        Thread.sleep(forTimeInterval: 10)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
