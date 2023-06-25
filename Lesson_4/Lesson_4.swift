import XCTest

final class Lesson_4: XCTestCase {
    
    let app = XCUIApplication()
    
    var toDoButton: XCUIElement!
    
    override func setUp() {
        toDoButton = app.buttons.matching(identifier: "todo_demo").firstMatch
        
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
    
    func testTask1() {
        
        app.launch()
        
        toDoButton.tap()
        sleep(1)
        
        let itemsAmount = 3
        
        Functions.createItems(amount: itemsAmount)
        
        print(app.debugDescription)
                
        XCTAssertEqual(app.cells.count, itemsAmount, "To-Do items amount doesn't match")
        
        let itemsName = app.cells.element.staticTexts.allElementsBoundByIndex
            var index = 1
            for labels in itemsName {
                XCTAssertEqual(labels.label, "Test Item \(index)", "To-Do item name doesn't match")
                    index += 1
                }
        }
    
    func testTask2() {
        
        app.launch()
        
        toDoButton.tap()
        sleep(1)
        
        if app.cells.count > 0 {
            Functions.deleteItems()
            Functions.createItems(amount: 4)
        } else {
            Functions.createItems(amount: 4)
        }
        
        let lastCellLabel = app.cells.staticTexts.element(boundBy: app.cells.count - 1).label
        
        Functions.moveLastItemToTheTop()
        
        let firstCellLabel = app.cells.staticTexts.element(boundBy: 0).label
        
        XCTAssertEqual(firstCellLabel, lastCellLabel, "The last item isn't moved to the top")
    }
    
    func testTask3() {
        
        app.launch()

        toDoButton.tap()
        sleep(1)
        
        if app.cells.count > 0 {
            Functions.deleteItems()
            Functions.createItems(amount: 4)
        } else {
            Functions.createItems(amount: 4)
        }
        
        let searchField = app.searchFields.firstMatch
        searchField.tap()
        let searchItemText = "Item 2"
        searchField.typeText(searchItemText)
        
        let remainedCells = app.cells.staticTexts.allElementsBoundByIndex
        
        var itemIsFound = false
        
        for labels in remainedCells {
            if labels.label.contains(searchItemText) {
                    itemIsFound = true
                }
            }
        XCTAssertTrue(itemIsFound, "There no items contain entered text")
    }
    
    func testTask4() {
        let timeout: TimeInterval = 10
        let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
        safari.launch()
        let safariSearchField = safari.textFields.matching(NSPredicate(format: "label == \"Address\"")).firstMatch
        safariSearchField.tap()
        safariSearchField.typeText("apalon.com")
        safari.keyboards.buttons["go"].tap()
        
        let websiteLoaded = safari.staticTexts.matching(NSPredicate(format: "label == \"An incredible team\"")).element.waitForExistence(timeout: timeout)
        
        XCTAssertTrue(websiteLoaded, "Failed to open apalon.com")
    }
    
    func testTask5() {
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        app.launch()
        let testAlert = app.buttons.staticTexts.matching(NSPredicate(format: "label == \"Show alert\"")).firstMatch
        testAlert.tap()
        sleep(1)
        app.buttons.matching(NSPredicate(format: "label == \"OK\"")).firstMatch.tap()
        let requestLocation = app.buttons.staticTexts.matching(NSPredicate(format: "label == \"Request location\"")).firstMatch
        requestLocation.tap()
        springboard.buttons.matching(NSPredicate(format: "label == \"Allow Once\"")).firstMatch.tap()
    }
    
    func testTask6() {
        app.launch()
        let requestLocation = app.buttons.staticTexts.matching(NSPredicate(format: "label == \"Request location\"")).firstMatch
        requestLocation.tap()
        app.tap()
    }
}
