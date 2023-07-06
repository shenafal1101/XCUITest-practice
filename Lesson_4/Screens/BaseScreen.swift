import Foundation
import XCTest

// Base class with common functionality
class BaseScreen {
    let app = XCUIApplication()
    
    func isScreenOpened() -> Bool {
        XCTAssertTrue(false, "isScreenOpened should be overridden")
        return false
    }
    
    func waitScreen(timeout: TimeInterval) {
        let currentTime = Date().timeIntervalSince1970
        
        while true {
            if isScreenOpened() {
                return
            }
            
            if Date().timeIntervalSince1970 - currentTime > timeout {
                return
            }
        }
    }
    
    func assertScreenOpened() {
        let className = NSStringFromClass(type(of: self))
        XCTAssertTrue(isScreenOpened(), className + " screen isn't opened")
    }
}
