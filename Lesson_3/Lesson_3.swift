import XCTest

final class Lesson_3: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        app.launch()
    }
    
    func testFindNavBar() {
        app.staticTexts["UI Samples"].tap()
        
        //Finding navigation bar
        let navigationBarQuery: XCUIElementQuery = app.navigationBars.containing(.staticText, identifier: "UI Samples")
        
        //Finding 'Back' button by label
        let backBtn = navigationBarQuery.buttons.matching(NSPredicate(format: "label == \"Back\"")).firstMatch
        backBtn.tap()
    }
    
    func testCreateAndDeleteTasks() {
        
        Functions.createItems(amount: 5)
        
        //Identify table element
        let listTable = app.tables.firstMatch
        
        //Identify any cell (in my case the first one)
        let listTableCell = listTable.children(matching: .cell).firstMatch
        
        //Swipe
        listTableCell.swipeLeft()
        
        //Find 'Delete' button in query and tap on it
        let itemDeleteBtn = listTableCell.children(matching: .button).element(boundBy: 0)
        itemDeleteBtn.tap()
    }
    
    func testPressHome() throws {
        XCUIDevice.shared.press(.home)
        sleep(10)
        app.activate()
    }
    
    func testCustomWaiter() {
        app.staticTexts["UI Samples"].tap()
        
        let buttonFirst: XCUIElement = app.buttons["First"]
        let buttonSecond: XCUIElement = app.buttons["Second"]
        
        // Check that button is selected and result is True
        print(app.waitForButtonToBeSelected(element: buttonFirst, timeout: 2))
        
        buttonSecond.tap()
        
        // Check that after selecting another button status is changed to False
        print(app.waitForButtonToBeSelected(element: buttonFirst, timeout: 2))
    }
    
    func testSwipeSpringboard() {
        
        // Press Home button
        XCUIDevice.shared.press(.home)
        
        // Initialize Springboard app
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        
        // Initialize Calendar icon in Springboard
        let calendar = springboard.icons.matching(identifier: "Calendar").firstMatch
        
        // Swipe
        while calendar.isHittable == false {
            springboard.customElementSwipe(element: springboard, swipeDirection: .right)
        }
        
        // Initialize Springboard window with all home screen icons
        let springboardWindow = springboard.windows.containing(.other, identifier:"Home screen icons").firstMatch
        
        // Initialize Settings icon
        let settingsIcon = springboardWindow.icons.matching(identifier: "Settings").firstMatch
        
        // Tap on Settings icon
        settingsIcon.tap()
        
    }
    
    func testMoveItem() {
        Functions.createItems(amount: 3)
        let editBtn = app.buttons.matching(NSPredicate(format: "label == \"Edit\"")).firstMatch
        editBtn.tap()
        let getLastItem = app.cells.element(boundBy: app.cells.count - 1)
        let getReorderIcon = getLastItem.frame.minX + getLastItem.frame.width * 0.9
        let searchBar = app.searchFields.firstMatch.frame
        
        let lastItemCoordinates = Functions.getCoordinates(x: getReorderIcon, y: getLastItem.frame.midY)
        
        let searchBarCoordinates = Functions.getCoordinates(x: searchBar.minX, y: searchBar.minY)
        
        lastItemCoordinates.press(forDuration: 1, thenDragTo: searchBarCoordinates)
    }
}
