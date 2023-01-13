//
//  _304_Repaso_Ciclos_Referencias_FuertesUITestsLaunchTests.swift
//  6304_Repaso_Ciclos_Referencias_FuertesUITests
//
//  Created by Dragon on 11/01/23.
//

import XCTest

class _304_Repaso_Ciclos_Referencias_FuertesUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
