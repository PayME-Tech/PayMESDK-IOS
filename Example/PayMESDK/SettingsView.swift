import UIKit

class SettingsView: UIViewController{
    private let PUBLIC_KEY: String =
    "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAKWcehEELB4GdQ4cTLLQroLqnD3AhdKi" + "\n" +
    "wIhTJpAi1XnbfOSrW/Ebw6h1485GOAvuG/OwB+ScsfPJBoNJeNFU6J0CAwEAAQ=="
    
    private let PRIVATE_KEY: String =
    "MIIBOwIBAAJBAOkNeYrZOhKTS6OcPEmbdRGDRgMHIpSpepulZJGwfg1IuRM+ZFBm"   + "\n" +
    "F6NgzicQDNXLtaO5DNjVw1o29BFoK0I6+sMCAwEAAQJAVCsGq2vaulyyI6vIZjkb"   + "\n" +
    "5bBId8164r/2xQHNuYRJchgSJahHGk46ukgBdUKX9IEM6dAQcEUgQH+45ARSSDor"   + "\n" +
    "mQIhAPt81zvT4oK1txaWEg7LRymY2YzB6PihjLPsQUo1DLf3AiEA7Tv005jvNbNC"   + "\n" +
    "pRyXcfFIy70IHzVgUiwPORXQDqJhWJUCIQDeDiZR6k4n0eGe7NV3AKCOJyt4cMOP"   + "\n" +
    "vb1qJOKlbmATkwIhALKSJfi8rpraY3kLa4fuGmCZ2qo7MFTKK29J1wGdAu99AiAQ"   + "\n" +
    "dx6DtFyY8hoo0nuEC/BXQYPUjqpqgNOx33R4ANzm9w=="
        
    private let APP_ID: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcHBJZCI6Njg2OH0.JyIdhQEX_Lx9CXRH4iHM8DqamLrMQJk5rhbslNW4GzY"
    
    let appToken: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(16)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "App Token"
        return label
    }()
    let appTokenTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 0.5
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    let appSecretKey: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(16)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "App Secret Key"
        return label
    }()
    let appSKTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 0.5
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    let appPublicKey: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(16)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "App Public Key"
        return label
    }()
    let appPKTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 0.5
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setLeftPaddingPoints(10)
        return textField
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 15
        button.setTitle("Save", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let checkBox: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let showLogLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(16)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Show Console log"
        return label
    }()
    
    let restoreButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 15
        button.setTitle("Restore default", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var isShowLog: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        self.view.backgroundColor = .white
       
        
        self.view.addSubview(appToken)
        self.view.addSubview(appTokenTextField)
        self.view.addSubview(appSecretKey)
        self.view.addSubview(appSKTextField)
        self.view.addSubview(appPublicKey)
        self.view.addSubview(appPKTextField)
        self.view.addSubview(saveButton)
        self.view.addSubview(checkBox)
        self.view.addSubview(showLogLabel)
        self.view.addSubview(restoreButton)
        
        let isShow = UserDefaults.standard.bool(forKey: "isShowLog")
        setShowLog(showLog: isShow)
        
        appToken.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 30).isActive = true
        appToken.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        
        appTokenTextField.topAnchor.constraint(equalTo: appToken.bottomAnchor, constant: 5).isActive = true
        appTokenTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        appTokenTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        appTokenTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        appTokenTextField.text = UserDefaults.standard.string(forKey: "appToken") ?? ""
        
        appSecretKey.topAnchor.constraint(equalTo: appTokenTextField.bottomAnchor, constant: 20).isActive = true
        appSecretKey.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        
        appSKTextField.topAnchor.constraint(equalTo: appSecretKey.bottomAnchor, constant: 5).isActive = true
        appSKTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        appSKTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        appSKTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        appSKTextField.text = UserDefaults.standard.string(forKey: "secretKey") ?? ""
        
        appPublicKey.topAnchor.constraint(equalTo: appSKTextField.bottomAnchor, constant: 20).isActive = true
        appPublicKey.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        
        appPKTextField.topAnchor.constraint(equalTo: appPublicKey.bottomAnchor, constant: 5).isActive = true
        appPKTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        appPKTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        appPKTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        appPKTextField.text = UserDefaults.standard.string(forKey: "publicKey") ?? ""
        
        
        saveButton.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor, constant: -30).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        saveButton.addTarget(self, action: #selector(onPressSave(_:)), for: .touchUpInside)
        
        checkBox.topAnchor.constraint(equalTo: appPKTextField.bottomAnchor, constant: 20).isActive = true
        checkBox.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        checkBox.heightAnchor.constraint(equalToConstant: 20).isActive = true
        checkBox.widthAnchor.constraint(equalToConstant: 20).isActive = true
        checkBox.addTarget(self, action: #selector(onPressCheckbox(_:)), for: .touchUpInside)

        showLogLabel.topAnchor.constraint(equalTo: appPKTextField.bottomAnchor, constant: 20).isActive = true
        showLogLabel.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 10).isActive = true
        
        restoreButton.topAnchor.constraint(equalTo: checkBox.bottomAnchor, constant: 20).isActive = true
        restoreButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        restoreButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        restoreButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        restoreButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        restoreButton.addTarget(self, action: #selector(onPressRestore(_:)), for: .touchUpInside)
    }
    
    func setShowLog(showLog: Bool) {
        isShowLog = showLog
        if (showLog) {
            checkBox.setImage(UIImage(named: "checked.svg"), for: .normal)
        } else {
            checkBox.setImage(UIImage(named: "uncheck.svg"), for: .normal)
        }
    }
    
    @IBAction func onPressCheckbox(_ sender: UIButton){
        setShowLog(showLog: !isShowLog)
    }
    
    @IBAction func onPressSave(_ sender: UIButton){
        UserDefaults.standard.set(self.appTokenTextField.text, forKey: "appToken")
        UserDefaults.standard.set(self.appSKTextField.text, forKey: "secretKey")
        UserDefaults.standard.set(self.appPKTextField.text, forKey: "publicKey")
        UserDefaults.standard.set(self.isShowLog, forKey: "isShowLog")
        navigationController?.popToRootViewController(animated: true)
//
//        let alert = UIAlertController(title: "Saved", message: "Đã lưu cài đặt!", preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onPressRestore(_ sender: UIButton){
        self.appTokenTextField.text = APP_ID
        self.appSKTextField.text = PRIVATE_KEY
        self.appPKTextField.text = PUBLIC_KEY
        self.isShowLog = false
    }
}

