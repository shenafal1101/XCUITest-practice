/*
 
 Lesson 2:
 
 - Create custom logger
 - Working with XCUIElementQuery class
 
 XCTestCase
 XCUIApplication
 XCUIElementQuery
 NSPredicate
 
 */

import XCTest

class Lesson_2: XCTestCase {
    
    let logger: Logger = Logger()
    let app = XCUIApplication()
    
    override func setUp() {
        logger.clearLogs()
    }
    
    override func tearDown() {
        logger.saveLogs()
    }
    
    /*
     
     Test case 1:
     1. Launch the app
     2. Open To-Do list screen
     3. Add one to-do item
     
     Using:
     - matching
     - .descendants
     - .firstMatch / .boundBy
     
     */
    
    func testCreateItem() {
        
        let toDoButton = app.buttons.matching(identifier: "todo_demo").firstMatch
        let itemTitleField = app.textFields.firstMatch
        let createButton = app.buttons.matching(NSPredicate(format: "label == \"Create\"")).firstMatch
        
        // Step 1
        app.launch()
        
        // Step 2
        toDoButton.tap()
        sleep(1)

        // Step 3
        app.navigationBars.descendants(matching: .button).element(boundBy: 2).tap()
        itemTitleField.tap()
        itemTitleField.typeText("Test Item")
        app.keyboards.buttons["Done"].tap()
        createButton.tap()
    }
    
    /*
     
     Test case 2:
     1. Launch the app
     2. Open To-Do list screen
     3. Add one to-do item with different picker wheel value
     
     Using:
     - matching
     - .descendants
     - .firstMatch / .boundBy
     - pickerWheel.adjust
     
     */
    
    func testPickerWheel() {
        
        let toDoButton = app.buttons.matching(identifier: "todo_demo").firstMatch
        let itemTitleField = app.textFields.firstMatch
        let pickerWheel = app.pickerWheels.firstMatch
        let createButton = app.buttons.matching(NSPredicate(format: "label == \"Create\"")).firstMatch

        // Step 1
        app.launch()
        
        // Step 2
        toDoButton.tap()
        sleep(1)

        // Step 3
        app.navigationBars.descendants(matching: .button).element(boundBy: 2).tap()
        itemTitleField.tap()
        itemTitleField.typeText("Test Item 2")
        app.keyboards.buttons["Done"].tap()
        sleep(1)
        pickerWheel.adjust(toPickerWheelValue: "Health")
        createButton.tap()
    }
    
    /*
     
     Test case 3:
     1. Launch Settings app by bundleIdentifier
     2. Find first Table element
     3. Get Cells array from Table element
     4. Get all .staticText elements from Cells array
     5. Save each label of .staticText element to logs via custom logger
     
     Using:
     - bundleIdentifier
     - matching
     - .children
     - .tebles / .cell
     - .firstMatch / .boundBy
     
     */
    
    func testSettingsLabels() {
        
        // Step 1
        let settingsApp = XCUIApplication(bundleIdentifier: "com.apple.Preferences")
        settingsApp.launch()
        
        // Step 2
        let tableFirstElement = settingsApp.tables.element(boundBy: 0).firstMatch
        
        // Step 3
        let cellArray = tableFirstElement.children(matching: .cell)
        
        // Step 4
        let staticTextElements = cellArray.children(matching: .staticText)
        
        // Step 5
        let allLabels = staticTextElements.allElementsBoundByAccessibilityElement
        for element in allLabels {
                logger.log(message: element.label)
            }
        }
    
    /*
     
     Test case 4:
     1. Launch Demo app
     2. Get all .staticText elements from main screen
     3. Save all labels of .staticText elements to logs via custom logger
     
     Using:
     - matching
     - .descendants
     */
    
    func testLogDemoText() {
        
        // Step 1
        app.launch()
        
        // Step 2
        let demoStaticTexts = app.descendants(matching: .staticText).allElementsBoundByAccessibilityElement
        
        // Step 3
        for element in demoStaticTexts {
            logger.log(message: element.label)
        }
    }

}
