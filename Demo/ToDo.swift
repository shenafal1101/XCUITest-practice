import Foundation

enum ToDoType: String {
    case OTHER = "Other"
    case SHOPPING = "Shopping"
    case WORK = "Work"
    case HOME = "Home"
    case HEALTH = "Health"
}

class ToDoItem: NSObject, NSCoding, NSSecureCoding {
    static var supportsSecureCoding: Bool = true
    
    var title: String
    var done: Bool
    var type: ToDoType
    
    public init(title: String) {
        self.title = title
        self.done = false
        self.type = .OTHER
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(forKey: "title") as? String else {
            return nil
        }
        self.title = title
        self.done = aDecoder.decodeBool(forKey: "done")
        if let typeString = aDecoder.decodeObject(forKey: "type") as? String,
           let type = ToDoType(rawValue: typeString) {
            self.type = type
        } else {
            self.type = .OTHER
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.done, forKey: "done")
        aCoder.encode(self.type.rawValue, forKey: "type")
    }
}

extension ToDoItem {
    public class func getMockData() -> [ToDoItem] {
        return [
            ToDoItem(title: "Milk"),
            ToDoItem(title: "Chocolate"),
            ToDoItem(title: "Light bulb"),
            ToDoItem(title: "Dog food")
        ]
    }
}

extension Collection where Iterator.Element == ToDoItem {
    private static func persistencePath() -> URL? {
        let url = try? FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true)
        
        return url?.appendingPathComponent("todoitems.bin")
    }
    
    func writeToPersistence() throws {
        if let url = Self.persistencePath() {
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: true)
                try data.write(to: url)
            } catch {
                throw error
            }
        } else {
            throw NSError(domain: "com.todosample.demo", code: 10, userInfo: nil)
        }
    }
    
    static func readFromPersistence() throws -> [ToDoItem] {
        if let url = persistencePath(), let data = try? Data(contentsOf: url) {
            do {
                if let array = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, ToDoItem.self], from: data) as? [ToDoItem] {
                    return array
                } else {
                    throw NSError(domain: "com.todosample.demo", code: 11, userInfo: nil)
                }
            } catch {
                throw error
            }
        } else {
            throw NSError(domain: "com.todosample.demo", code: 12, userInfo: nil)
        }
    }
}
