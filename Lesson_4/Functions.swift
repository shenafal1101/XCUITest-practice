import Foundation
import XCTest

class Functions {
    
    // Custom method to create specified amount of to-do items
    static func createItems(amount: Int) {
                    
            let app = XCUIApplication()
            
            // Create items
            for i in 1...amount {
                
                // Tap on Add button
                app.navigationBars.descendants(matching: .button).element(boundBy: 2).tap()
                
                // Set title for todo item
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
    
    // Custom method to clear to-do list (delete all items)
    static func deleteItems() {
        
        let app = XCUIApplication()
        
        let listTable = app.tables.firstMatch
        
        while app.cells.count != 0 {
            
            let listTableCell = listTable.children(matching: .cell).firstMatch
            
            listTableCell.swipeLeft()
            
            let itemDeleteBtn = listTableCell.children(matching: .button).element(boundBy: 0)
            itemDeleteBtn.tap()
        }
    }
    
    // Custom method to move the last to-do item from bottom to the top
    static func moveLastItemToTheTop() {
        
        let app = XCUIApplication()
        
        let editBtn = app.buttons.matching(NSPredicate(format: "label == \"Edit\"")).firstMatch
        editBtn.tap()
        let getLastItem = app.cells.element(boundBy: app.cells.count - 1)
        let getReorderIcon = getLastItem.frame.minX + getLastItem.frame.width * 0.9
        let searchBar = app.searchFields.firstMatch.frame
        
        let lastItemCoordinates = Functions.getCoordinates(x: getReorderIcon, y: getLastItem.frame.midY)
        
        let searchBarCoordinates = Functions.getCoordinates(x: searchBar.minX, y: searchBar.minY)
        
        lastItemCoordinates.press(forDuration: 1, thenDragTo: searchBarCoordinates)
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
