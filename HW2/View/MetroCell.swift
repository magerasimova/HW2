//
//  MetroCell.swift
//  HW2
//
//  Created by Майя Герасимова on 01.12.2020.
//

import UIKit

class MetroCell: UICollectionViewCell {
    

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    static let identifier = "MetroCell"
    
    func configure(with line: Line?){
        firstLabel.text = line?.name
        secondLabel.text = "Click"
    }
    
}
