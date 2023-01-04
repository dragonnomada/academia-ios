//
//  _301_ContadorApp_MVCTests.swift
//  5301_ContadorApp_MVCTests
//
//  Created by Dragon on 04/01/23.
//

import XCTest
@testable import _301_ContadorApp_MVC

class HomeView {
    
    var valor: Int?
    
    init() {
        ContadorController.shared.homeDelegate = self
        ContadorController.shared.actualizar()
    }
    
}

extension HomeView: ContadorHomeDelegate {
    func contador(conteoUpdated valor: Int) {
        print("El contador es: \(valor)")
        self.valor = valor
    }
}

class OperationsView {
    
    init() {
        ContadorController.shared.operationsDelegate = self
    }
    
    func incAction(veces: Int) {
        ContadorController.shared.incrementar(veces: veces)
    }
    
    func decAction(veces: Int) {
        ContadorController.shared.decrementar(veces: veces)
    }
    
    func resetAction() {
        ContadorController.shared.reiniciar()
    }
    
}

extension OperationsView: ContadorOperationsDelegate {
    func contador(conteoIncremented valor: Int) {
        print("Regresando a la vista principal: INC \(valor)")
    }
    
    func contador(conteoDecremented valor: Int) {
        print("Regresando a la vista principal: DEC \(valor)")
    }
    
    func contador(conteoReset valor: Int) {
        print("Regresando a la vista principal: RESET \(valor)")
    }
    
    func contador(conteoError error: String) {
        print("Mostrando alerta: ERROR \(error)")
    }
    
    
}

class _301_ContadorApp_MVCTests: XCTestCase {

    var homeView: HomeView?
    var operationsView: OperationsView?
    
    override func setUpWithError() throws {
        homeView = HomeView()
        operationsView = OperationsView()
    }

    override func tearDownWithError() throws {
        homeView = nil
        operationsView = nil
    }

    func testExample() throws {
        XCTAssertNotNil(homeView)
        XCTAssertNotNil(operationsView)
        
        if let homeView = homeView, let operationsView = operationsView {
            XCTAssertNotNil(homeView.valor)
            
            ContadorController.shared.reiniciar()
            
            if let valor = homeView.valor {
                
                XCTAssertTrue(valor == 0)
                
            }
            
            operationsView.incAction(veces: 4)
            
            if let valor = homeView.valor {
                
                XCTAssertTrue(valor == 4)
                
            }
            
            operationsView.incAction(veces: -4)
            
            if let valor = homeView.valor {
                
                XCTAssertTrue(valor == 4)
                
            }
            
            
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
