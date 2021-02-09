import UIKit

struct Product: Codable
{
    var id: Int
    var name: String
    var priceP: Int
}

class MenuViewController: UIViewController
{
    @IBOutlet weak var basketButton: UIButton!
    @IBOutlet weak var productTableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        productTableView.delegate = self
        productTableView.dataSource = self
        
        let defP = UserDefaults.standard
        var savedPrice = defP.object(forKey: "priceArray") as? [Int] ?? [Int]()
        
        savedPrice.removeAll()
        
        for i in 0...(products.count - 1)
        {
            savedPrice += Array(arrayLiteral: 0)
        }
        
        defP.set( savedPrice, forKey: "priceArray" )
        
        let defId = UserDefaults.standard
        var savedId = defId.object(forKey: "idArray") as? [Int] ?? [Int]()
        
        savedId.removeAll()
        
        print( savedId)
        defId.set( savedId, forKey: "idArray" )
    }
    
    @IBAction func BasketAction(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "showMenuBasket", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "showMenuBasket")
        {
            if let vc = segue.destination as? BasketViewController
            {
                vc.hidesBottomBarWhenPushed = true
            }
        }
    }
    
    var products =
    [
        Product( id: 1 , name: "Austria", priceP: 0 ),
        Product( id: 2 , name: "Belgium", priceP: 0 ),
        
    ]
}

class ProductTableViewCell: UITableViewCell
{
    var data: Product?
    var id: Int?
    var price: Int?
    {
        didSet
        {
            priceTextFieldCell?.text = String(price ?? 0)
        }
    }
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var nameCell: UILabel!
    @IBOutlet weak var minusButtonCell: UIButton!
    @IBOutlet weak var priceTextFieldCell: UITextField!
    @IBOutlet weak var plusButtonCell: UIButton!
    @IBOutlet weak var buyButtonCell: UIButton!
    
    @IBAction func textFieldEdingChanged(_ sender: UITextField)
    {
        price = Int(priceTextFieldCell.text!)
    }
    
    
    @IBAction func minusButtonAction(_ sender: UIButton)
    {
        if (self.price != nil) && ((self.price! - 1) >= 0)
        {
            self.price! -= 1
        }
        else
        {
            self.price = 0
        }
    }
    
    @IBAction func plusButtonAction(_ sender: UIButton)
    {
        if self.price != nil
        {
            self.price! += 1
        }
        else
        {
            self.price = 0
            self.price! += 1
        }
    }
    
    @IBAction func addToBasket(_ sender: UIButton)
    {
        if self.price == nil
        {
            self.price = 0
        }
        let defP = UserDefaults.standard
        var savedPrice = defP.object(forKey: "priceArray") as? [Int] ?? [Int]()
        
        savedPrice.remove( at: id! - 1)
        savedPrice.insert(price!, at: id! - 1)
        
        print( savedPrice)
        defP.set( savedPrice, forKey: "priceArray" )
        
        let defId = UserDefaults.standard
        var savedId = defId.object(forKey: "idArray") as? [Int] ?? [Int]()
        
        for (key , rowCart) in savedId.enumerated()
        {
            if rowCart == self.id
            {
                savedId.remove( at: key )
            }
        }
        
        savedId.append( id! )
        
        print( savedId)
        defId.set( savedId, forKey: "idArray" )
    }
    
    struct GlobalVariable
    {
        static var myStruct = [String]()
        static var myString = String()
    }
}

extension MenuViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print(indexPath)
    }
    
}

extension MenuViewController: UITableViewDataSource, UITextFieldDelegate
{
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = productTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell
        
        let row = products[indexPath.row]
        
        cell.nameCell?.text = row.name
        cell.priceTextFieldCell?.text = String(row.priceP)
        cell.imageCell?.image = UIImage(named: row.name)
        
        cell.data = row
        cell.id = row.id
        cell.price = row.priceP
        
        print(String(row.priceP) + "." + String(row.id))
        return cell
    }
}
