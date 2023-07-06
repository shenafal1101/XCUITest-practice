import Foundation
import XCTest

// Custom logger

class Logger {
    
    // The string is empty by default to indicate that no logs have been recorded yet
    private var logs: String = ""
    
    // Clears the logs by resetting the logs variable to an empty string
    func clearLogs() {
        logs = ""
    }
    
    // Logs a message by printing it to the console and appending it to the logs variable
    func log(message: String) {
        print(message)
        
        if logs.isEmpty {
            logs = message
        } else {
            logs = logs + "\n" + message
        }
    }
    
    // Saves the logs as an XCTAttachment within an XCTContext activity
    func saveLogs() {
        XCTContext.runActivity(named: "Save logs", block: { activity in
            
            // Create an XCTAttachment with the logs string
            let logsAttachment = XCTAttachment(string: logs)
            
            // Set a name for the attachment (optional)
            logsAttachment.name = "test_logs"
            
            // Set the lifetime of the attachment to keep it always
            logsAttachment.lifetime = .keepAlways

            // Add the logs attachment to the XCTContext activity
            activity.add(logsAttachment)
        })
    }
}
