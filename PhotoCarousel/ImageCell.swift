//
//  ImageCell.swift
//  PhotoCarousel
//
//  Created by Veliyan Georgiev on 3/8/17.
//  Copyright © 2017 VillyG. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    static let reuseIdentifer: String = String(describing: type(of: self))
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        contentView.addSubview(imageView)
        backgroundColor = UIColor.yellow
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0).isActive = true
        imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1.0).isActive = true
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 1.0).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 1.0).isActive = true
        
        
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
//        return attributes
//    }
    
}
