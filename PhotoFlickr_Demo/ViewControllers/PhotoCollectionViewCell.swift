//
//  PhotoCollectionViewCell.swift
//  PhotoFlickr_Demo
//
//  Created by Sarath on 27/05/17.
//  Copyright © 2017 Xcoder. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var backgroundImageOutlet: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
}
