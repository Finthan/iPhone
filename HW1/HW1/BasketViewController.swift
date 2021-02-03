import UIKit

class BasketViewController: UIViewController
{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var basketTableV: UITableView!
    @IBOutlet weak var deleteAllButton: UIButton!
    @IBOutlet weak var sumPrice: UILabel!
    
    var TotalSum: Float = 0 {
        didSet {
            sumPrice?.text = String(TotalSum ?? 0)
        }
    }
    
    var countries = [Country]()
    var basket = [Country]() {
        didSet {
            basketTableV.reloadData()
            sumPrice?.text = String(TotalSum ?? 0)
        }
    }
    
    @IBAction func deleteAllAction(_ sender: UIButton)
    {
        let def = UserDefaults.standard
        var savedCart = def.object(forKey: "cartArray") as? [Int] ?? [Int]()
        
        savedCart.removeAll()
        basket.removeAll()
        
        def.set( savedCart, forKey: "cartArray" )
        
        print(savedCart)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        basketTableV.delegate = self
        basketTableV.dataSource = self
        
        let def = UserDefaults.standard
        var savedCart = def.object(forKey: "cartArray") as? [Int] ?? [Int]()
        
        self.countries = [
            Country( id: 1 , isoCode: "at", name: "Austria", width: 100.0, length: 100.0 ),
            Country( id: 2 , isoCode: "be", name: "Belgium", width: 200.0, length: 100.0 ),
            Country( id: 3 , isoCode: "de", name: "Germany", width: 300.0, length: 100.0 ),
            Country( id: 4 , isoCode: "el", name: "Greece", width: 200.0, length: 100.0 ),
            Country( id: 5 , isoCode: "fr", name: "France", width: 300.0, length: 100.0 ),
        ]
        
        for rowCountries in countries
        {
            if savedCart.contains(rowCountries.id)
            {
                basket.append(rowCountries)
                self.TotalSum += rowCountries.width
            }
        }
        print( basket )
        
        
    }
}

class BasketTableViewCell: UITableViewCell
{
    var data: Country?
    var id: Int?
    
    @IBOutlet weak var imageBasketCell: UIImageView!
    @IBOutlet weak var nameBasketCell: UILabel!
    @IBOutlet weak var widthBasketCell: UILabel!
    @IBOutlet weak var lengthBasketCell: UILabel!
    @IBOutlet weak var priceBasketCell: UILabel!
    @IBOutlet weak var deleteBasketButton: UIButton!
    
    var addButtonTapAction : (()->())?
    
    @IBAction func deleteBasketElement(_ sender: UIButton)
    {
        addButtonTapAction?()
        
        let def = UserDefaults.standard
        var savedCart = def.object(forKey: "cartArray") as? [Int] ?? [Int]()
        
        for (key , rowCart) in savedCart.enumerated()
                {
            if rowCart == self.id {
                savedCart.remove( at: key )
            }
                }
        
        def.set( savedCart, forKey: "cartArray" )
        
    }
}

extension BasketViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("you tapped me!")
    }
}

extension BasketViewController: UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return basket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = basketTableV.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BasketTableViewCell
        
        let row = basket[indexPath.row]
        
        cell.nameBasketCell?.text = row.name
        cell.widthBasketCell?.text = String(row.width)
        cell.lengthBasketCell?.text = String(row.length)
        cell.priceBasketCell?.text = String(row.isoCode)
        cell.imageBasketCell?.image = UIImage(systemName: row.isoCode)
        
        cell.addButtonTapAction =
        {
            print([indexPath])
            self.basket.remove( at: indexPath.row )
        }
        
        cell.data = row
        cell.id = row.id
        
        return cell
    }
}
