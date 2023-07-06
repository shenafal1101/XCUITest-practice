/*
 
 Lesson 3:
 - Class extensions
 - Custom waiter
 - Create separate file with custom methods
 
 XCUIDevice
 XCUICoordinate
 NSPredicate
 switch
 while
 enum
 
 */

import XCTest

final class Lesson_3: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        app.launch()
    }
    
    /*
     
     Test case 1:
     1. Launch the app (step is within setUp method)
     2. Open UI Samples screen
     3. Find navigation bar by identifier
     4. Find 'Back' button by label -> back to the main screen
     
     Using:
     - .containing
     - NSPredicate
     
     */
    
    func testFindNavBar() {
        
        // Step 2
        app.staticTexts["UI Samples"].tap()
        
        // Step 3
        let navigationBarQuery: XCUIElementQuery = app.navigationBars.containing(.staticText, identifier: "UI Samples")
        
        // Step 4
        let backBtn = navigationBarQuery.buttons.matching(NSPredicate(format: "label == \"Back\"")).firstMatch
        backBtn.tap()
    }
    
    /*
     
     Test case 2:
     1. Launch the app (step is within setUp method)
     2. Open To-Do screen
     3. Create 5 to-do items
     4. Get table element
     5. Get the first cell
     6. Perform left swipe
     7. Delete to-do item
     
     Using:
     - Custom function to create to-do items
     - Swipe
     - .children
     
     */
    
    func testCreateAndDeleteTasks() {
        
        // Step 2 + Step 3
        Functions.createItems(amount: 5)
        
        // Step 4
        let listTable = app.tables.firstMatch
        
        // Step 5
        let listTableCell = listTable.children(matching: .cell).firstMatch
        
        // Step 6
        listTableCell.swipeLeft()
        
        // Step 7
        let itemDeleteBtn = listTableCell.children(matching: .button).element(boundBy: 0)
        itemDeleteBtn.tap()
    }
    
    /*
     
     Test case 3:
     1. Launch Demo app (step is within setUp method)
     2. Press 'Home' button
     3. Wait 10 sec
     4. Launch Demo app again
     
     Using:
     - XCUIDevice
     
     */
    
    func testPressHome() throws {
        
        // Step 2
        XCUIDevice.shared.press(.home)
        
        // Step 3
        sleep(10)
        
        // Step 4
        app.launch()
    }
    
    /*
     
     Test case 4:
     1. Launch the app (step is within setUp method)
     2. Open UI Samples screen
     3. Check that 'First' button is selected (status is True)
     4. Tap on 'Second' button (status of 'First' button is changed to False)
     
     Using:
     - custom waiter
     
     */
    
    func testCustomWaiter() {
        
        // Step 2
        app.staticTexts["UI Samples"].tap()
        
        let buttonFirst: XCUIElement = app.buttons["First"]
        let buttonSecond: XCUIElement = app.buttons["Second"]
        
        // Step 3
        print(app.waitForButtonToBeSelected(element: buttonFirst, timeout: 2))
        
        // Step 4
        buttonSecond.tap()
        print(app.waitForButtonToBeSelected(element: buttonFirst, timeout: 2))
    }
    
    /*
     
     Test case 5:
     1. Launch the app (step is within setUp method)
     2. Press Home button
     3. Create Springboard app
     4. Swipe the screen until the Calendar icon appears
     5. Find Window
     6. Find 'Settings' icon within Window and tap on it
     
     Using:
     - springboard app
     - custom swipe method
     - .isHittable
     - .windows
     
     */
    
    func testSwipeSpringboard() {
        
        // Step 2
        XCUIDevice.shared.press(.home)
        
        // Step 3
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        
        // Step 4: Initialize Calendar icon in Springboard, swipe
        let calendar = springboard.icons.matching(identifier: "Calendar").firstMatch
        
        while calendar.isHittable == false {
            springboard.customElementSwipe(element: springboard, swipeDirection: .right)
        }
        
        // Step 5: Initialize Springboard window with all home screen icons
        let springboardWindow = springboard.windows.containing(.other, identifier:"Home screen icons").firstMatch
        
        // Step 6
        let settingsIcon = springboardWindow.icons.matching(identifier: "Settings").firstMatch
        settingsIcon.tap()
        
    }
    
    /*
     
     Test case 6
     1. Launch the app (step is within setUp method)
     2. Open To-Do screen
     3. Create 3 to-do items
     4. Tap on 'Edit' button
     5. Move the last item to the top
     
     Using:
     - XCUICoordinate
     - custom method to calculate the normalized offset for the XCUICoordinate
     
     */
    
    func testMoveItem() {
        
        // Step 2 + Step 3
        Functions.createItems(amount: 3)
        
        // Step 4
        let editBtn = app.buttons.matching(NSPredicate(format: "label == \"Edit\"")).firstMatch
        editBtn.tap()
        
        // Step 5
        let getLastItem = app.cells.element(boundBy: app.cells.count - 1)
        let getReorderIcon = getLastItem.frame.minX + getLastItem.frame.width * 0.9
        let searchBar = app.searchFields.firstMatch.frame
        let lastItemCoordinates = Functions.getCoordinates(x: getReorderIcon, y: getLastItem.frame.midY)
        let searchBarCoordinates = Functions.getCoordinates(x: searchBar.minX, y: searchBar.minY)
        
        lastItemCoordinates.press(forDuration: 1, thenDragTo: searchBarCoordinates)
    }
}
