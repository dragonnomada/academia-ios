import XCTest
@testable import DetailsLibrary

final class DetailsLibraryTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(DetailsLibrary().text, "Hello, World!")
    }
    
    func testFoodService() {
        
        let service = FoodService()
        
        NotificationCenter.default.addObserver(self, selector: #selector(foodCreatedObserver), name: NSNotification.Name("foodCreatedService"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(foodCreatedObserver), name: NSNotification.Name("foodCreatedService"), object: nil)
        
        service.createFood(id: 123, name: "papaya", calorias: 12, carbs: 34, fat: 56, fiber: 78, protein: 90, suggar: 1, units: 2)
        
    }
    
    @objc func foodCreatedObserver(notification: Notification) {
        
        print("Se ha creado un food")
        
        if let food = notification.object as? FoodEntity {
         
            print(food)
            
        }
        
    }
}
