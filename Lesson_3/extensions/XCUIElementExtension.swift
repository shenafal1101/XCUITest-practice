import XCTest

public extension XCUIElement {
    
    func waitForElementEnabled(timeout: TimeInterval) -> Bool {
        
        let currentTime = Date().timeIntervalSince1970
        
        while true {
            if self.exists && self.isEnabled {
                return true
            }
            
            if Date().timeIntervalSince1970 - currentTime > timeout {
                return false
            }
        }
    }
    
    func waitForButtonToBeSelected(element: XCUIElement, timeout: TimeInterval) -> Bool {
        let startTime = Date()
        var selected = element.isSelected
        
        while !selected && Date().timeIntervalSince(startTime) < timeout {
            print("isSelected: \(element.isSelected)") // Additional debug info about element status
            sleep(1)
            selected = element.isSelected
        }
        
        return selected
    }
    
    enum swipeDirections {
            case left
            case right
            case up
            case down
        }
    
    func customElementSwipe(element: XCUIElement, swipeDirection: swipeDirections) {
        switch swipeDirection {
        case .left:
            element.swipeLeft()
        case .right:
            element.swipeRight()
        case .up:
            element.swipeUp()
        case .down:
            element.swipeDown()
        }
    }
}
