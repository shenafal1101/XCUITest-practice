import UIKit

class ToDoController: UITableViewController, UISearchResultsUpdating, AddTaskControllerProtocol {
    
    //    private var todoItems = ToDoItem.getMockData()
    private var todoItems = [ToDoItem]()
    private var filteredToDo: [ToDoItem]!
    private var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "To-Do list"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ToDoController.didTapAddItemButton(_:)))
        
        let editBtn = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(ToDoController.didTapEditItemButton(_:)))
        
        
        self.navigationItem.leftBarButtonItems = [editBtn]
        
        self.navigationItem.leftItemsSupplementBackButton = true

            
        // Setup a notification to let us know when the app is about to close,
        // and that we should store the user items to persistence. This will call the
        // applicationDidEnterBackground() function in this class
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(UIApplicationDelegate.applicationDidEnterBackground(_:)),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil)
        
        do {
            // Try to load from persistence
            self.todoItems = try [ToDoItem].readFromPersistence()
        }
        catch let error as NSError {
            if error.domain == NSCocoaErrorDomain && error.code == NSFileReadNoSuchFileError {
                NSLog("No persistence file found, not necesserially an error...")
            }
            else {
                let alert = UIAlertController(
                    title: "Error",
                    message: "Could not load the to-do items!",
                    preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
                NSLog("Error loading from persistence: \(error)")
            }
        }
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        
        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense. Should probably only set
        // this to yes if using another controller to display the search results.
        if #available(iOS 13.0, *) {
            searchController.obscuresBackgroundDuringPresentation = false
        } else {
            searchController.dimsBackgroundDuringPresentation = false
        }
        
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Search to do"
        tableView.tableHeaderView = searchController.searchBar
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredToDo != nil{
            return filteredToDo.count
        }
        
        return todoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo_cell", for: indexPath)
    
        var showCells: [ToDoItem] = todoItems
        if filteredToDo != nil{
            showCells = filteredToDo
        }
        
        if indexPath.row < showCells.count
        {
            let item = showCells[indexPath.row]
            cell.textLabel?.text = item.title
            
            let accessory: UITableViewCell.AccessoryType = item.done ? .checkmark : .none
            cell.accessoryType = accessory
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if indexPath.row < todoItems.count{
            let item = todoItems[indexPath.row]
            item.done = !item.done
            
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.todoItems[sourceIndexPath.row]
        todoItems.remove(at: sourceIndexPath.row)
        todoItems.insert(movedObject, at: destinationIndexPath.row)
        NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \(todoItems)")
        // To check for correctness enable: self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if filteredToDo != nil{
            if let index = todoItems.firstIndex(where: {$0 == filteredToDo[indexPath.row]}) {
                filteredToDo.remove(at: indexPath.row)
                todoItems.remove(at: index)
            }
            tableView.deleteRows(at: [indexPath], with: .top)
            
        }else if indexPath.row < todoItems.count {
            todoItems.remove(at: indexPath.row)
            if filteredToDo != nil{
                filteredToDo.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .top)
        }
        
        do {
            try todoItems.writeToPersistence()
        }
        catch let error {
            NSLog("Error writing to persistence: \(error)")
        }
    }
    
    internal func addNewToDoItem(title: String){
        let newIndex = todoItems.count
        
        todoItems.append(ToDoItem(title: title))
        
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .top)
        
        do {
            try todoItems.writeToPersistence()
        }
        catch let error {
            NSLog("Error writing to persistence: \(error)")
        }
    }
    
    //    @objc func didTapAddItemButton(_ sender: UIBarButtonItem){
    //        // Create an alert
    //        let alert = UIAlertController(
    //            title: "New to-do item",
    //            message: "Insert the title of the new to-do item:",
    //            preferredStyle: .alert)
    //
    //        // Add a text field to the alert for the new item's title
    //        alert.addTextField(configurationHandler: nil)
    //
    //        // Add a "cancel" button to the alert. This one doesn't need a handler
    //        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    //
    //        // Add a "OK" button to the alert. The handler calls addNewToDoItem()
    //        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
    //            if let title = alert.textFields?[0].text
    //            {
    //                self.addNewToDoItem(title: title)
    //            }
    //        }))
    //
    //        // Present the alert to the user
    //        self.present(alert, animated: true, completion: nil)
    //    }
    
    @objc func didTapAddItemButton(_ sender: UIBarButtonItem){
        let addToDoController = AddTaskController()
        addToDoController.delegate = self
        self.navigationController?.pushViewController(addToDoController, animated: true)
    }
    
    @objc func didTapEditItemButton(_ sender: UIBarButtonItem){
        self.isEditing = true
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    
    @objc
    public func applicationDidEnterBackground(_ notification: NSNotification) {
        do {
            try todoItems.writeToPersistence()
        }
        catch let error {
            NSLog("Error writing to persistence: \(error)")
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredToDo = todoItems.filter{
                return $0.title.lowercased().contains(searchText.lowercased())
            }
        } else {
            filteredToDo = nil
        }
        
        tableView.reloadData()
    }
}
