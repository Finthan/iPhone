import UIKit

class RegistViewController: UIViewController
{
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmationPasswordField: UITextField!
    @IBOutlet weak var customerRegistrationButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loginField.delegate = self
        nameField.delegate = self
        surnameField.delegate = self
        passwordField.delegate = self
        confirmationPasswordField.delegate = self
    }
    
    @IBAction func CustomerAction(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "showRegistCustomer", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.identifier == "showRegistCustomer"
        {
            if let vc = segue.destination as? CustomerViewController
            {
                //делаем отправку данных о регистрации и вход в приложение
                vc.hidesBottomBarWhenPushed = true
            }
        }
    }
}

extension RegistViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        let login = loginField.text!
        let name = nameField.text!
        let surname = surnameField.text!
        let password = passwordField.text!
        let confirmationPassword = confirmationPasswordField.text!
        
        return true
    }
}
