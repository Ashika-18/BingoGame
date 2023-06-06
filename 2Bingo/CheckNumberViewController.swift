import UIKit

class CheckNumberViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var checkValue: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("\(checkValue)")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return checkValue.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NumberCell", for: indexPath) as! NumberCell
        
        if cell.numberLabel == nil {
            
            cell.numberLabel = UILabel()
            
            cell.contentView.addSubview(cell.numberLabel)
            // 必要に応じて、numberLabelの制約を設定するなど、セル内でのレイアウトを調整します
        }
        
        cell.numberLabel.text = checkValue[indexPath.item]
        
        return cell
    }

    class NumberCell: UICollectionViewCell {
        
        @IBOutlet var numberLabel: UILabel!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            configureNumberLabel()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            configureNumberLabel()
        }
        
        private func configureNumberLabel() {
            numberLabel = UILabel(frame: contentView.bounds)
            numberLabel.textAlignment = .center
            contentView.addSubview(numberLabel)
        }
    }

}
