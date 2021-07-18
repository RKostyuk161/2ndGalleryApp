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
