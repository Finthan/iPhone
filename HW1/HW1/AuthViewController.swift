import UIKit

class AuthViewController: UIViewController
{
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registButton: UIButton!
    @IBOutlet weak var customerAuthButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func RegistAction(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "showRegister", sender: nil)
    }
    
    @IBAction func CustomerAction(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "showAuthCustomer", sender: nil)
        print(1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showAuthCustomer"
        {
            if let vc = segue.destination as? CustomerViewController
            {
                //делаем отправку данных о входе и проверку
                vc.hidesBottomBarWhenPushed = true
            }
        }
        else if segue.identifier == "showRegister"
        {
            if let vc = segue.destination as? AuthViewController
            {
                vc.hidesBottomBarWhenPushed = true
            }
        }
    }
}
