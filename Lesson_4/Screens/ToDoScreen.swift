import Foundation
import XCTest

class ToDoScreen: BaseScreen {
    
    var itemsCountBeforeDeletion = 0
    var itemsCountAfterDeletion = 0
    
    //MARK: - Elements
    public func addBtn() -> XCUIElement {
        return app.buttons.element(matching: NSPredicate(format: "label == 'Add'")).firstMatch
    }
    
    public func searchField() -> XCUIElement {
        return app.searchFields.firstMatch
    }
    
    public func searchRemainedCells() -> [XCUIElement] {
        return app.cells.staticTexts.allElementsBoundByIndex
    }
    
    public func listTable() -> XCUIElement {
        return app.tables.firstMatch
    }
    
    public func listTableCell() -> XCUIElement {
        return listTable().children(matching: .cell).firstMatch
    }
    
    public func deleteBtn() -> XCUIElement {
        return listTableCell().children(matching: .button).element(boundBy: 0)
    }
    
    //MARK: - Functions
    override func isScreenOpened() -> Bool {
        return addBtn().exists
    }
    
    func deleteItems() {
        while app.cells.count != 0 {
            listTableCell().swipeLeft()
            deleteBtn().tap()
        }
    }
    
    func deleteFirstItem() {
        itemsCountBeforeDeletion = app.cells.count
        listTableCell().swipeLeft()
        deleteBtn().tap()
        itemsCountAfterDeletion = app.cells.count
    }
    
    func checkDeletion() {
        XCTAssertEqual(itemsCountBeforeDeletion, itemsCountAfterDeletion + 1, "Item isn't deleted")
    }
    
    func checkSearchResult() {
        var itemIsFound = false
        let textToSearch = searchField().value as! String
        for labels in searchRemainedCells() {
            if labels.label.contains(textToSearch) {
                    itemIsFound = true
                }
            }
        XCTAssertTrue(itemIsFound, "There no items contain entered text")
    }
    
    //MARK: - Steps
    func tapAddBtn() {
        addBtn().tap()
    }
    
    func tapSearchField() {
        searchField().tap()
    }
    
    func searchFieldEnterText(searchText: String) {
        searchField().typeText(searchText)
    }

}
