import Foundation
import XCTest

// Custom function to take and save screenshots
class Helper {
    
    func takeScreenshot(screenshotName: String) {
        XCTContext.runActivity(named: "Take screenshot: \(screenshotName)", block: { activity in
            
            // Capture a screenshot of the main screen
            let mainScreenScreenshot = XCUIScreen.main.screenshot()
            
            // Create an XCTAttachment with the screenshot
            let attachment = XCTAttachment(screenshot: mainScreenScreenshot, quality: .original)
            
            // Set the lifetime of the attachment to keep it always
            attachment.lifetime = .keepAlways
            
            // Set the name of the attachment to the provided screenshot name
            attachment.name = screenshotName
            
            // Add the screenshot attachment to the XCTContext activity
            activity.add(attachment)
        })
    }
}

