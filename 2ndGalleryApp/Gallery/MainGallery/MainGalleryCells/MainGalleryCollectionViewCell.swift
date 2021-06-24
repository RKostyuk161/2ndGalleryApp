//
//  MainGalleryCollectionViewCell.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import UIKit
import Kingfisher

class MainGalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var activityIndicatorOfCollectionViewCell: UIActivityIndicatorView!
    @IBOutlet weak var imageOfCollectionViewCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicatorOfCollectionViewCell.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageOfCollectionViewCell.kf.cancelDownloadTask()
        imageOfCollectionViewCell.image = nil
    }
    
    func setupCell(url: String) {
        imageOfCollectionViewCell.kf.indicatorType = .activity
        let url = URL(string: "http://gallery.dev.webant.ru/media/" + url)
        imageOfCollectionViewCell.kf.setImage(with: url)
        imageOfCollectionViewCell.layer.cornerRadius = 10
        imageOfCollectionViewCell.layer.borderWidth = 0.7
        imageOfCollectionViewCell.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        contentView.layer.masksToBounds = true
        

        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 4.5
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor
    }
    
}
