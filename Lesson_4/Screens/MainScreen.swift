import Foundation
import XCTest

class MainScreen: BaseScreen {
    
    //MARK: - Elements
    public func toDoBtn() -> XCUIElement {
        return app.buttons.matching(identifier: "todo_demo").firstMatch
    }
    
    public func uiSamplesBtn() -> XCUIElement {
        return app.buttons.element(matching: NSPredicate(format: "label == 'UI Samples'"))
    }
    
    //MARK: - Functions
    override func isScreenOpened() -> Bool {
        return toDoBtn().exists
    }
    
    //MARK: - Steps
    func tapToDoBtn() {
        toDoBtn().tap()
    }
    
    func tapUiSamplesBtn() {
        uiSamplesBtn().tap()
    }
}
