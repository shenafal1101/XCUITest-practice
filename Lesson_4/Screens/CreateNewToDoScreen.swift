import Foundation
import XCTest

class CreateNewToDoScreen: BaseScreen {
    
    //MARK: - Elements
    
    public func createBtn() -> XCUIElement {
        return app.buttons.element(matching: NSPredicate(format: "label == 'Create'")).firstMatch
    }
    
    public func textField() -> XCUIElement {
        return app.textFields.firstMatch
    }
    
    public func keyboardDone() -> XCUIElement {
        return app.keyboards.buttons["Done"]
    }
    
    //MARK: - Functions
    
    override func isScreenOpened() -> Bool {
        return createBtn().exists
    }
    
    func clearItemsList() {
        if ToDoScreen().app.cells.count > 0 {
            ToDoScreen().deleteItems()
        }
    }
    
    func createItems(amount: Int) {
        
        // Clear Item List if any items exist before test
        ToDoScreen().deleteItems()
        
        for i in 1...amount {
            ToDoScreen().tapAddBtn()
            CreateNewToDoScreen().waitScreen(timeout: 10)
            CreateNewToDoScreen().assertScreenOpened()
            tapTextField()
            textField().typeText("Test Item \(i)")
            tapKeyboardDone()
            tapCreateBtn()
            sleep(1)
        }
    }
    
    
    //MARK: - Steps
    
    func tapTextField() {
        textField().tap()
    }
    
    func tapKeyboardDone() {
        keyboardDone().tap()
    }
    
    func tapCreateBtn() {
        createBtn().tap()
    }
}
