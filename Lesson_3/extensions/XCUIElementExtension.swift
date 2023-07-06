import XCTest

public extension XCUIElement {
    
    // Custom waiter 1
    func waitForElementEnabled(timeout: TimeInterval) -> Bool {
        
        let currentTime = Date().timeIntervalSince1970
        
        // Wait until the element exists and becomes enabled or timeout is reached
        while true {
            if self.exists && self.isEnabled {
                return true
            }
            
            // Check if the timeout has been reached
            if Date().timeIntervalSince1970 - currentTime > timeout {
                return false
            }
        }
    }
    
    // Custom waiter 2
    func waitForButtonToBeSelected(element: XCUIElement, timeout: TimeInterval) -> Bool {
        
        let startTime = Date()
        
        // Check if the element is initially selected
        var selected = element.isSelected
        
        // Wait until the button is selected or timeout is reached
        while !selected && Date().timeIntervalSince(startTime) < timeout {
            
            // Additional debug info about the element status
            print("isSelected: \(element.isSelected)")
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
    
    // Custom swipe method with different directions
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
