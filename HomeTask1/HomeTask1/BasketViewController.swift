import UIKit

class BasketViewController: UIViewController {

    @IBOutlet weak var basketTableView: UITableView!
    @IBOutlet weak var deleteAllProductsButton: UIButton!
    
    var theStruct = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        basketTableView.delegate = self
        basketTableView.dataSource = self
        
        let defId = UserDefaults.standard
        var savedId = defId.object(forKey: "idArray") as? [Int] ?? [Int]()
        
        self.products =
        [
            Product( id: 1 , name: "Austria", priceP: 0 ),
            Product( id: 2 , name: "Belgium", priceP: 0 ),
        ]
        
        for rowCountries in products
        {
            if savedId.contains(rowCountries.id)
            {
                basket.append(rowCountries)
                //self.TotalSum += rowCountries.width
            }
        }
        
        defId.set( savedId, forKey: "idArray" )
    }
    
    var products = [Product]()
    var basket = [Product]()
    {
        didSet
        {
            basketTableView.reloadData()
        }
    }
    
    @IBAction func deleteAllAction(_ sender: Any)
    {
        basket.removeAll()
        
        let defId = UserDefaults.standard
        var savedId = defId.object(forKey: "idArray") as? [Int] ?? [Int]()
        
        savedId.removeAll()
        
        print( savedId)
        defId.set( savedId, forKey: "idArray" )
    }
    
}

class BasketTableViewCell: UITableViewCell
{
    var data: Product?
    var id: Int?
    
    @IBOutlet weak var imageBasketCell: UIImageView!
    @IBOutlet weak var nameBasketCell: UILabel!
    @IBOutlet weak var priceBasketCell: UILabel!
    @IBOutlet weak var deleteBasketButtonCell: UIButton!
    
    var addButtonTapAction : (()->())?
    
    @IBAction func deleteBasketElement(_ sender: UIButton)
    {
        addButtonTapAction?()
        
        let defP = UserDefaults.standard
        var savedPrice = defP.object(forKey: "priceArray") as? [Int] ?? [Int]()
        
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
        
        defId.set( savedId, forKey: "idArray" )
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
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return basket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = basketTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BasketTableViewCell
        
        let row = basket[indexPath.row]
        
        let defP = UserDefaults.standard
        var savedPrice = defP.object(forKey: "priceArray") as? [Int] ?? [Int]()
        
        let defId = UserDefaults.standard
        var savedId = defId.object(forKey: "idArray") as? [Int] ?? [Int]()
        
        var rowPrice = savedId[indexPath.row]
        
        for row_id in savedId
        {
            if savedCart.contains(rowCountries.id)
            {
                basket.append(rowCountries)
                self.TotalSum += rowCountries.width
            }
        }
        
        print ( "row = ", indexPath.row, "rowPrice = ", rowPrice )
        cell.nameBasketCell?.text = row.name
        cell.priceBasketCell?.text = String(savedPrice[indexPath.row])
        cell.imageBasketCell?.image = UIImage(systemName: row.name)
        
        cell.addButtonTapAction =
        {
            //self.TotalSum -= row.width
            self.basket.remove( at: indexPath.row )
        }
        
        cell.data = row
        cell.id = row.id
        
        defP.set( savedPrice, forKey: "priceArray" )
        defId.set( savedId, forKey: "idArray" )
        
        return cell
    }
}
