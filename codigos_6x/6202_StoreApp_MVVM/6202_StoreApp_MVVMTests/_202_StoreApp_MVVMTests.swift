//
//  _202_StoreApp_MVVMTests.swift
//  6202_StoreApp_MVVMTests
//
//  Created by Dragon on 10/01/23.
//

import XCTest
@testable import _202_StoreApp_MVVM
import Combine

class _202_StoreApp_MVVMTests: XCTestCase {

    var storeModelSubscriber: AnyCancellable?
    
    override func setUpWithError() throws {
        storeModelSubscriber = StoreModel.shared.objectWillChange.sink {
            
            print("Modelo actualizado:")
            print("Frutas:")
            StoreModel.shared.fruits.forEach { fruta in
                print("\(fruta.name ?? "SIN NOMBRE") [\(fruta.amount) KG]")
            }
            print("Índice Seleccionado: \(StoreModel.shared.selectedIndex ?? -1)")
            print("Fruta Seleccionada: \(StoreModel.shared.selectedFruit?.name ?? "NINGUNA")")
            
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
    }
    
    func testStoreModel() {
        
        StoreModel.shared.addFruit(name: "Prueba \(Int.random(in: 1...Int.max))", amount: Double.random(in: 1...100))
        
        print("Esperando 2 segundos...")
        Thread.sleep(forTimeInterval: 2)
        
        StoreModel.shared.selectFruit(index: 0)
        
        print("Esperando 2 segundos...")
        Thread.sleep(forTimeInterval: 2)
        
        StoreModel.shared.updateFruit(name: nil, amount: Double.random(in: 123...124))
        
        print("Esperando 2 segundos...")
        Thread.sleep(forTimeInterval: 2)
        
        StoreModel.shared.deleteFruit()
        
        print("Prueba finalizada")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
