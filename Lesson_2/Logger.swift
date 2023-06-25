import Foundation
import XCTest

class Logger {
    private var logs: String = ""
    
    func clearLogs() {
        logs = ""
    }
    
    func log(message: String) {
        print(message)
        
        if logs.isEmpty {
            logs = message
        } else {
            logs = logs + "\n" + message
        }
    }
    
    func saveLogs() {
        XCTContext.runActivity(named: "Save logs", block: {(activity) in
            let logsAttachment = XCTAttachment.init(string: logs)
            logsAttachment.name = "test_logs"
            logsAttachment.lifetime = .keepAlways

            activity.add(logsAttachment)
        })
    }
}
