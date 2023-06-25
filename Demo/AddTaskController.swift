import UIKit

protocol AddTaskControllerProtocol {
    func addNewToDoItem(title: String)
}

class AddTaskController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate: AddTaskControllerProtocol?
    var todoTitleTextField: UITextField!
    var dobButton: UIButton!
    let toDoTypes: [ToDoType] = [ToDoType.OTHER, ToDoType.HOME, ToDoType.WORK,ToDoType.HEALTH]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New todo"
        self.view.backgroundColor = .white
        
        initViews()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func initViews(){
        initTitleTextFiled()
        initCreateButton()
        initPriorityPicker()
    }
    
    func initTitleTextFiled(){
        todoTitleTextField =  UITextField(frame: CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 40))
        
        todoTitleTextField.placeholder = "Title"
        todoTitleTextField.font = UIFont.systemFont(ofSize: 15)
        todoTitleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        todoTitleTextField.autocorrectionType = UITextAutocorrectionType.no
        todoTitleTextField.keyboardType = UIKeyboardType.default
        todoTitleTextField.returnKeyType = UIReturnKeyType.done
        todoTitleTextField.clearButtonMode = UITextField.ViewMode.whileEditing;
        todoTitleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        todoTitleTextField.delegate = self
        
        self.view.addSubview(todoTitleTextField)
    }
    
    func initPriorityPicker(){
        let priorityPickerView: UIPickerView = UIPickerView()
        priorityPickerView.accessibilityIdentifier = "priority_picker_view"
        priorityPickerView.frame = CGRect(x: 0, y: 200, width: self.view.bounds.width, height: 150)
        
        
        priorityPickerView.delegate = self
        priorityPickerView.dataSource = self
        
        self.view.addSubview(priorityPickerView)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return toDoTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return toDoTypes[row].rawValue
    }
    
//    @objc func updateDOBClick(_ sender: UIButton) {
//        let picker : UIDatePicker = UIDatePicker()
//
//        picker.datePickerMode = UIDatePickerMode.date
//        picker.addTarget(self, action: #selector(dueDateChanged(sender:)), for: UIControlEvents.valueChanged)
//        let pickerSize : CGSize = picker.sizeThatFits(CGSize.zero)
//        picker.frame = CGRect(x:0.0, y:250, width:pickerSize.width, height:460)
//        // you probably don't want to set background color as black
//        // picker.backgroundColor = UIColor.blackColor()
//        self.view.addSubview(picker)
//    }
//
//    @objc func dueDateChanged(sender:UIDatePicker){
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .short
//        dateFormatter.timeStyle = .none
//        dobButton.setTitle(dateFormatter.string(from: sender.date), for: .normal)
//    }
    
    func initCreateButton(){
        let createBtn: UIButton = UIButton(type: .system)
        createBtn.setTitle("Create", for: UIControl.State.normal)
        createBtn.sizeToFit()
        createBtn.center = self.view.center
        
        createBtn.addTarget(self, action: #selector(AddTaskController.createTodo(_:)), for: .touchUpInside)
        createBtn.accessibilityIdentifier = "creat_todo_btn"
        
        createBtn.frame.origin.y = self.view.frame.height - 100
        
        self.view.addSubview(createBtn)
        
    }
    
    @objc func createTodo(_ sender:UIButton!) {
        print("Button tapped")
        if !(todoTitleTextField.text?.isEmpty)! {
            _ = navigationController?.popViewController(animated: true)
            delegate?.addNewToDoItem(title: todoTitleTextField.text!)
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }


}
