/*
 
 Lesson 1:
 
 - Basic interaction with elements
 - Custom function to take and save sceenshots
 
 XCTestCase
 XCUIElement
 XCUIApplication

 */

import XCTest

class Lesson_1: XCTestCase {
    
    let helper = Helper()

    override func setUpWithError() throws {
        continueAfterFailure = true
    }

    override func tearDownWithError() throws {
        
    }
    
    /*
     
     Test case:
     1. Launch the app
     2. Add first to-do item
     3. Add second to-do item with different picker wheel value
     4. Delete to-do items
     5. Back to main menu
     
     Save screenshot to attachment after each step
     
     */
    
    func testExample() throws {
        
        let app = XCUIApplication()
        let toDoListNavigationBar = app.navigationBars["To-Do list"]
        let addButton = toDoListNavigationBar.buttons["Add"]
        let titleTextField = app.textFields["Title"]
        let doneButton = app.keyboards.buttons["Done"]
        let createButton = app.staticTexts["Create"]
        let editButton = toDoListNavigationBar.buttons["Edit"]
        let tablesQuery = app.tables
        let deleteButton = tablesQuery/*@START_MENU_TOKEN@*/.buttons["Delete"]/*[[".cells.buttons[\"Delete\"]",".buttons[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        // Step 1
        app.launch()
        app/*@START_MENU_TOKEN@*/.staticTexts["TODO"]/*[[".buttons[\"TODO\"].staticTexts[\"TODO\"]",".buttons[\"todo_demo\"].staticTexts[\"TODO\"]",".staticTexts[\"TODO\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(1)
        helper.takeScreenshot(screenshotName: "To-Do list screen is opened")
        
        // Step 2
        addButton.tap()
        titleTextField.tap()
        titleTextField.typeText("Test1")
        doneButton.tap()
        createButton.tap()
        sleep(1)
        helper.takeScreenshot(screenshotName: "Test1 note is created")
        
        // Step 3
        addButton.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: "Home")
        sleep(1)
        helper.takeScreenshot(screenshotName: "Picker wheels value is changed")
        titleTextField.tap()
        titleTextField.typeText("Test2")
        doneButton.tap()
        createButton.tap()
        sleep(1)
        helper.takeScreenshot(screenshotName: "Test2 note is created")
        
        // Step 4
        editButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.buttons["Delete Test1"]/*[[".cells.buttons[\"Delete Test1\"]",".buttons[\"Delete Test1\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        deleteButton.tap()
        sleep(1)
        helper.takeScreenshot(screenshotName: "Test1 note is deleted")
        tablesQuery/*@START_MENU_TOKEN@*/.cells.buttons["Delete Test2"]/*[[".cells.buttons[\"Delete Test2\"]",".buttons[\"Delete Test2\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        deleteButton.tap()
        sleep(1)
        helper.takeScreenshot(screenshotName: "Test2 note is deleted")
        
        // Step 5
        toDoListNavigationBar.buttons["Done"].tap()
        let backButton = toDoListNavigationBar.buttons["Back"]
        backButton.tap()
        sleep(1)
        helper.takeScreenshot(screenshotName: "Back to main menu")
    }
}
