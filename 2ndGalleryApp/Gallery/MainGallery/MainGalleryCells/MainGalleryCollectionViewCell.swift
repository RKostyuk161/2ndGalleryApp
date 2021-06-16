//
//  MainGalleryCollectionViewCell.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import UIKit
import Kingfisher

class MainGalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageOfCollectionViewCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageOfCollectionViewCell.kf.cancelDownloadTask()
        imageOfCollectionViewCell.image = nil
    }
    
    func setupCell(url: String) {
        let url = URL(string: url)
        imageOfCollectionViewCell.kf.setImage(with: url)
    }
    
}
