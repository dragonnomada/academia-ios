//
//  DemoTest.swift
//  3406_XCTestsTests
//
//  Created by User on 22/12/22.
//

import XCTest

///
/// Hemos definido una clase llamada `Contador` la cuál retiene
/// un conteo y posee los métodos incrementar y decrementar.
///
/// En esta prueba verificaremos que se pueda incrementar y decrementar
/// correctamente acertando los resultados esperados.
///
/// Para poder probar nuestras clases definidas en el proyecto, tenemos que
/// importarlo marcando `@testable` antes del `import`.
///
/// **Nota:** Si el nombre del proyecto empieza con número, reemplaza
///             el número con un `_`
///

@testable import _406_XCTests

final class DemoTests: XCTestCase {
    
    /// **PASO 1** - Definimos las instancias que ocuparemos
    var contador: Contador?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        /// **PASO 2** - Ajustamos las instancias (creamos nuevas)
        contador = Contador()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        /// **PASO 3** - Liberamos las instancias que ya no se utilizan
        contador = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        /// **PASO 4** - Realizar la prueba unitaria
        
        XCTAssertNotNil(contador, "El contador es nil")
        
        // Si el contador?.conteo no es cero
        // se producirá un error y la prueba fallará
        XCTAssertTrue(contador?.conteo == 0, "El contador no es cero")
        
        contador?.incrementar()
        contador?.incrementar()
        
        XCTAssertTrue(contador?.conteo == 2, "El contador no es 2")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            
            for _ in 1...10 {
                contador?.incrementar()
            }
            
            XCTAssert(contador?.conteo == 10)
            
            for _ in 1...10 {
                contador?.decrementar()
            }
            
            XCTAssert(contador?.conteo == 0)
            
        }
    }

}
