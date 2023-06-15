import UIKit

class CheckNumberViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var backButton: UIButton!
    
    //画面遷移後の値を保持する変数
    var receivedRandomNumber: BingoViewController.RandomNumber?
    
    var checkValue: [String] = []
    
    var randomNums = Array(1...75)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.layer.cornerRadius = 10.0
        
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCell")
    }
}

extension CheckNumberViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                
        return randomNums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CollectionViewCell
        
        let number = randomNums[indexPath.item]
            cell.label.text = "\(number)"
        
        if checkValue.contains("\(number)") {
            cell.backgroundColor = UIColor.blue
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "backButton" {
            
            if let bingoVC = segue.destination as? BingoViewController {
                
                bingoVC.randomValues = checkValue.compactMap{ Int($0) }
            }
        }
    }
}


