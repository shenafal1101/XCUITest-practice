import XCTest

class Lesson_1: XCTestCase {
    let helper = Helper()

    override func setUpWithError() throws {
        continueAfterFailure = true
    }

    override func tearDownWithError() throws {
        
    }

    func testExample() throws {
        // Launch the app
        let app = XCUIApplication()
        app.launch()

        app/*@START_MENU_TOKEN@*/.staticTexts["TODO"]/*[[".buttons[\"TODO\"].staticTexts[\"TODO\"]",".buttons[\"todo_demo\"].staticTexts[\"TODO\"]",".staticTexts[\"TODO\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let toDoListNavigationBar = app.navigationBars["To-Do list"]

        let addButton = toDoListNavigationBar.buttons["Add"]
        
        
        // Add first note
        addButton.tap()
        
        let titleTextField = app.textFields["Title"]
        titleTextField.tap()
        titleTextField.typeText("Test1")
        
        let doneButton = app.keyboards.buttons["Done"]
        doneButton.tap()
        
        let createButton = app.staticTexts["Create"]
        createButton.tap()
        sleep(1)
        helper.takeScreenshot(screenshotName: "Test1 note is created")
                        
        // Add second note with another picker wheels value
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
        
        
        // Delete notes
        let editButton = toDoListNavigationBar.buttons["Edit"]
        editButton.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.buttons["Delete Test1"]/*[[".cells.buttons[\"Delete Test1\"]",".buttons[\"Delete Test1\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        
        let deleteButton = tablesQuery/*@START_MENU_TOKEN@*/.buttons["Delete"]/*[[".cells.buttons[\"Delete\"]",".buttons[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        deleteButton.tap()
        sleep(1)
        helper.takeScreenshot(screenshotName: "Test1 note is deleted")
        tablesQuery/*@START_MENU_TOKEN@*/.cells.buttons["Delete Test2"]/*[[".cells.buttons[\"Delete Test2\"]",".buttons[\"Delete Test2\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        deleteButton.tap()
        sleep(1)
        helper.takeScreenshot(screenshotName: "Test2 note is deleted")
        toDoListNavigationBar.buttons["Done"].tap()
        
        // Back to main menu
        let backButton = toDoListNavigationBar.buttons["Back"]
        backButton.tap()
        sleep(1)
        helper.takeScreenshot(screenshotName: "Back to main menu")
    }
}
