import UIKit

class ViewController: UIViewController {
    
    private var isCaptured = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLabel()
        secureScreen()
        NotificationCenter.default.addObserver(self, selector: #selector(screenCaptureChanged), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
    }
    
    
    @IBAction func nxtbtn(_ sender: Any) {
        
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NextVC") as? NextVC else{ return }
       
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func screenCaptureChanged() {
        isCaptured = UIScreen.main.isCaptured
        if isCaptured {
            updateScreenCapture(status: isCaptured)
        }
    }
    
    private func updateScreenCapture(status: Bool) {
        DispatchQueue.main.async {
            if status {
                self.appDelegate.window?.makeSecure()
                print("Screen has been captured!")
            }
        }
    }
    
    func addLabel() {
        let label = UILabel()
        label.text = "AppSquadz"
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
        view.addSubview(label)
    }
    
    func secureScreen() {
        if let window = UIApplication.shared.windows.first {
            window.makeSecure()
        }
    }
}

extension UIWindow {

    func makeSecure() {
        let field = UITextField()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: field.frame.self.width, height: field.frame.self.height))
        field.isSecureTextEntry = true
        self.addSubview(field)
        self.layer.superlayer?.addSublayer(field.layer)
        field.layer.sublayers?.last!.addSublayer(self.layer)
        field.leftView = view
        field.leftViewMode = .always
    }
}

extension UIViewController {
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var sceneDelegate: SceneDelegate {
        return UIApplication.shared.delegate as! SceneDelegate
    }
}
