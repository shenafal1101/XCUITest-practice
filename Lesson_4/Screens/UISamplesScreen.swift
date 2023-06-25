import Foundation
import XCTest

class UISamplesScreen: BaseScreen {
    
    //MARK: - Elements
    
    public func pickerWheel() -> XCUIElement {
        return app.pickerWheels.firstMatch
    }
    
    public func firstBtn() -> XCUIElement {
        return app.buttons.element(matching: NSPredicate(format: "label == 'First'"))
    }
    
    public func secondBtn() -> XCUIElement {
        return app.buttons.element(matching: NSPredicate(format: "label == 'Second'"))
    }
    
    public func switcher() -> XCUIElement {
        return app.switches.matching(identifier: "test_switcher3").firstMatch
    }
    
    //MARK: - Functions
    
    override func isScreenOpened() -> Bool {
        return pickerWheel().exists
    }
    
    //MARK: - Steps
    
    func tapFirstBtn() {
        firstBtn().tap()
    }
    
    func tapSecondBtn() {
        secondBtn().tap()
    }
    
    func changeSwitcherVaule() {
        switcher().tap()
    }
}
