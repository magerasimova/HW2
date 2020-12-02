//
//  ImageCell.swift
//  HW2
//
//  Created by Майя Герасимова on 01.12.2020.
//

import UIKit

class ImageCell: UICollectionViewCell {
    static let identifier = "ImageCell"
    
    @IBOutlet private weak var imageView: UIImageView!
    
    func configure(with image: UIImage?) {
        imageView.image = image
    }
    
}
