import UIKit

struct Country: Codable
{
    var id: Int
    var isoCode: String
    var name: String
    var width: Float
    var length: Float
}

class CustomerViewController: UIViewController
{
    @IBOutlet weak var basketButton: UIButton!
    @IBOutlet weak var productTableView: UITableView!
    
    @IBAction func BasketAction(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "showCustomerBasket", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        print(segue.identifier)
        if (segue.identifier == "showCustomerBasket")
        {
            if let vc = segue.destination as? BasketViewController
            {
                vc.hidesBottomBarWhenPushed = true
            }
        }
    }
    
    var countries = [
        Country( id: 1 , isoCode: "at", name: "Austria", width: 100.0, length: 100.0 ),
        Country( id: 2 , isoCode: "be", name: "Belgium", width: 200.0, length: 100.0 ),
        Country( id: 3 , isoCode: "de", name: "Germany", width: 300.0, length: 100.0 ),
        Country( id: 4 , isoCode: "el", name: "Greece", width: 200.0, length: 100.0 ),
        Country( id: 5 , isoCode: "fr", name: "France", width: 300.0, length: 100.0 ),
    ]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        productTableView.delegate = self
        productTableView.dataSource = self
    }
    
}

class ProductTableViewCell: UITableViewCell
{
    var data: Country?
    var id: Int?
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var nameCell: UILabel!
    @IBOutlet weak var widthCell: UILabel!
    @IBOutlet weak var lengthCell: UILabel!
    @IBOutlet weak var priceButtonCell: UIButton!
    
    @IBAction func addToBasket(_ sender: UIButton)
    {
        let def = UserDefaults.standard
        var savedCart = def.object(forKey: "cartArray") as? [Int] ?? [Int]()
        
        for (key , rowCart) in savedCart.enumerated()
                        {
                    if rowCart == self.id {
                        savedCart.remove( at: key )
                    }
                        }
        savedCart.append( id! )
        print( savedCart )
        def.set( savedCart, forKey: "cartArray" )
        //savedCart.append( data? )
        //def.set( try? PropertyListEncoder().encode(savedCart) , forKey: "cartArray” )
    }
}

extension CustomerViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("you tapped me!")
    }
}

extension CustomerViewController: UITableViewDataSource
{

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = productTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell
        
        let row = countries[indexPath.row]
        
        cell.nameCell?.text = row.name
        cell.widthCell?.text = String(row.width)
        cell.lengthCell?.text = String(row.length)
        cell.priceButtonCell.setTitle(row.isoCode, for: .normal)
        cell.imageCell?.image = UIImage(named: row.isoCode)
        
        cell.data = row
        cell.id = row.id
        
        return cell
    }
    
}
