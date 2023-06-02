//
//  CheckNumberViewController.swift
//  2Bingo
//
//  Created by Kazuhiro Ashiba on 2023/05/30.
//

import UIKit

class CheckNumberViewController: UIViewController, UICollectionViewDataSource {
    
    class CustomCell: UICollectionViewCell {
        @IBOutlet weak var textLabel: UILabel!
        
    }

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var checkValue: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        
        print("\(checkValue)")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return checkValue.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCell
            
            let value = checkValue[indexPath.item]
            
            cell.textLabel.text = value
            
            return cell
        }
    }
    

