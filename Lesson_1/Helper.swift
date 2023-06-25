import Foundation
import XCTest

class Helper {
    
    func takeScreenshot(screenshotName: String) {
        XCTContext.runActivity(named: "Take screenshot: \(screenshotName)", block: {(activity) in
            
            let mainScreenScreenshot = XCUIScreen.main.screenshot()
            
            let attachment = XCTAttachment.init(screenshot: mainScreenScreenshot, quality: .original)
            attachment.lifetime = .keepAlways
            attachment.name = screenshotName
            
            activity.add(attachment)
        })
    }
}
