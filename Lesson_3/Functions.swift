import Foundation
import XCTest

class Functions {
    
    // Create provided amount of to-do items
    static func createItems(amount: Int) {
                    
            let app = XCUIApplication()
            
            // Open To-Do list screen
            let toDoButton = app.buttons.matching(identifier: "todo_demo").firstMatch
            toDoButton.tap()
            sleep(1)
            
            // Create items
            for i in 1...amount {
                
                // Tap on Add button
                app.navigationBars.descendants(matching: .button).element(boundBy: 2).tap()
                
                // Set title for to-do item
                let itemTitleField = app.textFields.firstMatch
                itemTitleField.tap()
                itemTitleField.typeText("Test Item \(i)")
                // Close keyboard
                app.keyboards.buttons["Done"].tap()
                
                // Tap on Create button
                let createButton = app.buttons.matching(NSPredicate(format: "label == \"Create\"")).firstMatch
                createButton.tap()
                sleep(1)
            }
        }
    
    // Calculate the normalized offset for the XCUICoordinate
    static func getCoordinates(x: CGFloat, y: CGFloat) -> XCUICoordinate {
        let app = XCUIApplication()
        
        // The normalized offset is a value between 0 and 1 representing a fraction of the app's frame width and height
        let normalizedOffset = CGVector(
            dx: x < 1 ? x : x / app.frame.width,
            dy: y < 1 ? y : y / app.frame.height
        )
        
        // Return an XCUICoordinate object with the normalized offset
        return app.coordinate(withNormalizedOffset: normalizedOffset)
    }
}
