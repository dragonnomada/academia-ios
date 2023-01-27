//
//  RecetAppTests.swift
//  RecetAppTests
//
//  Created by MacBook  on 26/01/23.
//

import XCTest
@testable import RecetApp

final class RecetAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRecipeApiService() async {
        
        let service = RecipeApiService()
        
        service.search(query: "bread")
        
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        
    }

}
