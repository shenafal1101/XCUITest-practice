/*
 
 Lesson 4: Page Object pattern
 
 */

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
    
    /*
     
     Test case 1:
     1. Launch the app
     2. Open To-Do screen
     3. Create 3 to-do items (if list isn't empty - clear it)
     
     Using:
     - Page Object pattern
     - Asserts to check if specified screen is opened
     
     */
    
    func testPageObjectCreateItems() {
        mainScreen.waitScreen(timeout: 10)
        mainScreen.assertScreenOpened()
        mainScreen.tapToDoBtn()
        
        toDoScreen.waitScreen(timeout: 10)
        toDoScreen.assertScreenOpened()
        
        createNewToDoScreen.createItems(amount: 3)

    }
    
    /*
     
     Test case 2:
     1. Launch the app
     2. Open To-Do screen
     3. Tap to search field
     4. Enter specified text
     
     Using:
     - Page Object pattern
     - Asserts to check if specified screen is opened
     - Asserts to check search result
     
     */
    
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
    
    /*
     
     Test case 3:
     1. Launch the app
     2. Open To-Do screen
     3. Delete first to-do item
     
     Using:
     - Page Object pattern
     - Asserts to check if specified screen is opened
     - Assert to check that item is deleted
     
     */
    
    func testPageObjectDeleteItem() {
        mainScreen.waitScreen(timeout: 10)
        mainScreen.assertScreenOpened()
        mainScreen.tapToDoBtn()
        
        toDoScreen.waitScreen(timeout: 10)
        toDoScreen.assertScreenOpened()
        toDoScreen.deleteFirstItem()
        toDoScreen.checkDeletion()
    }
    
    /*
     
     Test case 4:
     1. Launch the app
     2. Open UI Samples screen
     3. Tap on 'First' button
     4. Tap on 'Second' button
     5. Tap on switcher to change its value
     
     Using:
     - Page Object pattern
     - Asserts to check if specified screen is opened
     
     */
    
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
