//
//  FullImageViewControllerExtensions.swift
//  2ndGalleryApp
//
//  Created by Роман on 16.07.2021.
//

import Foundation
import UIKit

extension FullImageInfoViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.contentStackView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.nameLabel.isHidden = true
        self.descriptoinLabel.isHidden = true
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        scrollView.setZoomScale(1, animated: true)
        self.nameLabel.isHidden = false
        self.descriptoinLabel.isHidden = false
        self.reloadInputViews()
        scrollView.layoutSubviews()
        scrollView.setNeedsDisplay()
        self.contentStackView.layoutSubviews()
        self.contentStackView.updateConstraints()
    }
}

extension FullImageInfoViewController: FullImageInfoView {
    func setView(image: String?, name: String?, desription: String?, username: String?, userDate: String?) {
        setImage(name: image)
        setImageName(imageName: name)
        setImageDescription(description: desription)
        setUserFields(username: username, userDate: userDate)
        
    }
    
    func setImage(name: String?) {
        guard let name = name else { return }
        let url = URL(string: "http://gallery.dev.webant.ru/media/\(name)")
        self.image.kf.indicatorType = .activity
        self.image.kf.setImage(with: url)
    }
    
    func setImageDescription(description: String?) {
        self.descriptoinLabel.text = description ?? ""
    }
    
    func setImageName(imageName: String?) {
        self.nameLabel.text = imageName ?? ""
    }
    
    func setUserFields(username: String?,
                       userDate: String?) {
        self.userNameLabel.text = username ?? R.string.alert.nodataMessage()
        self.birthDayUserNameLabel.text = userDate ?? R.string.alert.nodataMessage()
        guard var date = userDate else { return }
        let range = date.index(date.endIndex, offsetBy: -15)..<date.endIndex
        date.removeSubrange(range)
        self.birthDayUserNameLabel.text = date
    }
}
