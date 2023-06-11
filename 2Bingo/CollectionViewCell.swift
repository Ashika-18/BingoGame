//
//  CollectionViewCell.swift
//  2Bingo
//
//  Created by Kazuhiro Ashiba on 2023/06/08.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundColor = .gray
    }

}
