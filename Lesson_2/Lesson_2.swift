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
    
    func testCreateItem() {
        app.launch()
        
        // Open To-Do list screen
        let toDoButton = app.buttons.matching(identifier: "todo_demo").firstMatch
        toDoButton.tap()
        sleep(1)

        // Tap on Add button
        app.navigationBars.descendants(matching: .button).element(boundBy: 2).tap()
        
        // Set title for todo item
        let itemTitleField = app.textFields.firstMatch
        itemTitleField.tap()
        itemTitleField.typeText("Test Item")
        // Close keyboard
        app.keyboards.buttons["Done"].tap()
        
        // Tap on Create button
        let createButton = app.buttons.matching(NSPredicate(format: "label == \"Create\"")).firstMatch
        createButton.tap()
    }
    
    
    func testPickerWheel() {
        
        app.launch()
        
        // Open To-Do list screen
        let toDoButton = app.buttons.matching(identifier: "todo_demo").firstMatch
        toDoButton.tap()
        sleep(1)

        // Tap on Add button
        app.navigationBars.descendants(matching: .button).element(boundBy: 2).tap()
        
        // Set title for todo item
        let itemTitleField = app.textFields.firstMatch
        itemTitleField.tap()
        itemTitleField.typeText("Test Item 2")
        // Close keyboard
        app.keyboards.buttons["Done"].tap()
        sleep(1)
        
        // Change picker wheel value
        let pickerWheel = app.pickerWheels.firstMatch
        pickerWheel.adjust(toPickerWheelValue: "Health")
        
        // Tap on Create button
        let createButton = app.buttons.matching(NSPredicate(format: "label == \"Create\"")).firstMatch
        createButton.tap()
    }
    
    func testSettingsLabels() {
        
        // Run Settings app
        let settingsApp = XCUIApplication(bundleIdentifier: "com.apple.Preferences")
        settingsApp.activate()
        
        // Finding first Table element
        let tableFirstElement = settingsApp.tables.element(boundBy: 0).firstMatch
        
        // Getting Cells array from Table element
        let cellArray = tableFirstElement.children(matching: .cell)
        
        // Getting all .staticText elements from Cells array
        let staticTextElements = cellArray.children(matching: .staticText)
        
        // Getting labels from each .staticText element
        let allLabels = staticTextElements.allElementsBoundByAccessibilityElement
        
        // Saving each label in logs
        for element in allLabels {
                logger.log(message: element.label)
            }
        
        }
    
    func testLogDemoText() {
        app.activate()
        
        // Getting all .staticText elements from main screen
        let demoStaticTexts = app.descendants(matching: .staticText).allElementsBoundByAccessibilityElement
        
        // Saving all labels of .staticText elements to logs
        for element in demoStaticTexts {
            logger.log(message: element.label)
        }
    }

    }
