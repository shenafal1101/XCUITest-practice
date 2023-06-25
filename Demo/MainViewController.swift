import CoreLocation
import UIKit

class MainViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var showTestAlertBtn: UIButton!
    @IBOutlet weak var askLocationBtn: UIButton!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        
        showTestAlertBtn.addTarget(self, action: #selector(self.callAlertClicked), for: .touchUpInside)
        askLocationBtn.addTarget(self, action: #selector(self.askLocation), for: .touchUpInside)
        
        
    }
    
    @objc func callAlertClicked(_ sender: Any?) {
        let alert = UIAlertController(
            title: "Test alert",
            message: "Hello, I am a test alert!",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func askLocation(_ sender: Any?){
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                }
            }
        }
    }
    
}
