import Foundation
import XCTest


class PageObjectTest: XCTestCase {
    let app = XCUIApplication()
    let mainScreen: MainScreen = MainScreen()
    let toDoScreen: ToDoScreen = ToDoScreen()
    let createNewToDoScreen: CreateNewToDoScreen = CreateNewToDoScreen()
    let uiSamplesScreen: UISamplesScreen = UISamplesScreen()
    
    override func setUp() {
        app.launch()
    }
    
    func testPageObjectCreateItems() {
        mainScreen.waitScreen(timeout: 10)
        mainScreen.assertScreenOpened()
        mainScreen.tapToDoBtn()
        
        toDoScreen.waitScreen(timeout: 10)
        toDoScreen.assertScreenOpened()
        
        createNewToDoScreen.createItems(amount: 3)

    }
    
    func testPageObjectSearchItemByName() {
        mainScreen.waitScreen(timeout: 10)
        mainScreen.assertScreenOpened()
        mainScreen.tapToDoBtn()
        
        toDoScreen.waitScreen(timeout: 10)
        toDoScreen.assertScreenOpened()
        toDoScreen.tapSearchField()
        toDoScreen.searchFieldEnterText(searchText: "Item 2")
        toDoScreen.checkSearchResult()
    }
    
    func testPageObjectDeleteItem() {
        mainScreen.waitScreen(timeout: 10)
        mainScreen.assertScreenOpened()
        mainScreen.tapToDoBtn()
        
        toDoScreen.waitScreen(timeout: 10)
        toDoScreen.assertScreenOpened()
        toDoScreen.deleteFirstItem()
        toDoScreen.checkDeletion()
    }
    
    func testPageObjectUiSamples() {
        mainScreen.waitScreen(timeout: 10)
        mainScreen.assertScreenOpened()
        mainScreen.tapUiSamplesBtn()
        
        uiSamplesScreen.waitScreen(timeout: 10)
        uiSamplesScreen.assertScreenOpened()
        uiSamplesScreen.tapFirstBtn()
        uiSamplesScreen.tapSecondBtn()
        uiSamplesScreen.changeSwitcherVaule()
    }
}
