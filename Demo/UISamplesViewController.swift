import UIKit

class UISampleViewController: UIViewController {
    
override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "UI Samples"
    self.view.backgroundColor = .white
    
    self.hideKeyboardWhenTappedAround()
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}
}

extension UISampleViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "test \(row)"
    }

}
