/*
 
 Lesson 4:
 - Asserts
 - Allerts
 
 XCTAssert
 addUIInterruptionMonitor
 
 */

import XCTest

final class Lesson_4: XCTestCase {
    
    let app = XCUIApplication()
    
    var toDoButton: XCUIElement!
    
    override func setUp() {
        toDoButton = app.buttons.matching(identifier: "todo_demo").firstMatch
        
    // Handling Alert Interruptions
    addUIInterruptionMonitor(withDescription: "Tracking Permission alerts") { (alert) -> Bool in
            guard alert.exists else {
                XCTFail("Alert not found")
                return false
            }

            switch alert.label {
            case "Allow “Demo” to use your location?":
                alert.buttons["Allow Once"].tap()
                return true
            default:
                return false
            }
        }
    }
    
    /*
     
     Test case 1:
     1. Launch the app
     2. Open To-Do screen
     3. Create 3 to-do items
     4. Check items amount
     5. Check items names
     
     Using:
     - XCTAssertEqual
     
     */
    
    func testItemsAmountNames() {
        
        // Step 1
        app.launch()
        
        // Step 2
        toDoButton.tap()
        sleep(1)
        
        // Step 3
        let itemsAmount = 3
        Functions.createItems(amount: itemsAmount)
        
        // Step 4
        XCTAssertEqual(app.cells.count, itemsAmount, "To-Do items amount doesn't match")
        
        // Step 5
        let itemsName = app.cells.element.staticTexts.allElementsBoundByIndex
            var index = 1
            for labels in itemsName {
                XCTAssertEqual(labels.label, "Test Item \(index)", "To-Do item name doesn't match")
                    index += 1
                }
        }
    
    /*
     
     Test case 2:
     1. Launch the app
     2. Open To-Do screen
     3. Create 3 to-do items with different names (if list is empty)
     4. Move the last item to the top
     5. Check that the last item is moved to the top
     
     Using:
     - XCTAssertEqual
     
     */
    
    func testMoveLastItemToTheTop() {
        
        // Step 1
        app.launch()
        
        // Step 2
        toDoButton.tap()
        sleep(1)
        
        // Step 3
        if app.cells.count > 0 {
            Functions.deleteItems()
            Functions.createItems(amount: 4)
        } else {
            Functions.createItems(amount: 4)
        }
        
        // Step 4
        let lastCellLabel = app.cells.staticTexts.element(boundBy: app.cells.count - 1).label
        Functions.moveLastItemToTheTop()
        let firstCellLabel = app.cells.staticTexts.element(boundBy: 0).label
        
        // Step 5
        XCTAssertEqual(firstCellLabel, lastCellLabel, "The last item isn't moved to the top")
    }
    
    /*
     
     Test case 3:
     1. Launch the app
     2. Open To-Do screen
     3. Create 3 to-do items with different names (if list is empty)
     4. Enter multiple symbols into search field
     5. Check that only items which contain entered symbols are displayed
     
     Using:
     - XCTAssertTrue
     
     */
    
    func testSearchSpecificItem() {
        
        // Step 1
        app.launch()

        // Step 2
        toDoButton.tap()
        sleep(1)
        
        // Step 3
        if app.cells.count > 0 {
            Functions.deleteItems()
            Functions.createItems(amount: 4)
        } else {
            Functions.createItems(amount: 4)
        }
        
        // Step 4
        let searchField = app.searchFields.firstMatch
        searchField.tap()
        
        let searchItemText = "Item 2"
        searchField.typeText(searchItemText)
        
        // Step 5
        let remainedCells = app.cells.staticTexts.allElementsBoundByIndex
        var itemIsFound = false
        
        for labels in remainedCells {
            if labels.label.contains(searchItemText) {
                    itemIsFound = true
                }
            }
        XCTAssertTrue(itemIsFound, "There no items contain entered text")
    }
    
    /*
     
     Test case 4:
     1. Launch Safari app
     2. Open 'www.apalon.com' website
     3. Wait until website is loaded
     4. Check that website is loaded
     
     Using:
     - XCTAssertTrue
     
     */
    
    func testWebsiteIsLoaded() {
        
        // Preconditions: set website loading timeout
        let timeout: TimeInterval = 10
        
        // Step 1
        let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
        safari.launch()
        
        // Step 2
        let safariSearchField = safari.textFields.matching(NSPredicate(format: "label == \"Address\"")).firstMatch
        safariSearchField.tap()
        safariSearchField.typeText("apalon.com")
        safari.keyboards.buttons["go"].tap()
        
        // Step 3: set a constant variable to define that website is loaded
        let websiteLoaded = safari.staticTexts.matching(NSPredicate(format: "label == \"An incredible team\"")).element.waitForExistence(timeout: timeout)
        
        // Step 4
        XCTAssertTrue(websiteLoaded, "Failed to open apalon.com")
    }
    
    /*
     
     Test case 5:
     1. Launch the app
     2. Tap on 'Show alert' to call test alert
     3. Tap on 'OK' button to close test alert
     4. Tap on 'Request location' to call ALS alert
     5. Tap on 'Allow Once' to close ALS alert
     
     Using:
     - Sprigboard
     - NSPredicate
     
     */
    
    func testCloseAlerts() {
        
        // Springboard is in focus when system alert appeared
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        
        // Step 1
        app.launch()
        
        // Step 2
        let testAlert = app.buttons.staticTexts.matching(NSPredicate(format: "label == \"Show alert\"")).firstMatch
        testAlert.tap()
        sleep(1)
        
        // Step 3
        app.buttons.matching(NSPredicate(format: "label == \"OK\"")).firstMatch.tap()
        
        // Step 4
        let requestLocation = app.buttons.staticTexts.matching(NSPredicate(format: "label == \"Request location\"")).firstMatch
        requestLocation.tap()
        
        // Step 5
        springboard.buttons.matching(NSPredicate(format: "label == \"Allow Once\"")).firstMatch.tap()
    }
    
}
