//
//  MainGalleryFooterCollectionReusableView.swift
//  2ndGalleryApp
//
//  Created by Роман on 26.07.2021.
//

import UIKit

class MainGalleryFooterCollectionReusableView: UICollectionReusableView {
    
    var timer: Timer?
    
    @IBOutlet weak var footerActivityIndicator: UIImageView!
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        startTimer()
    }
    
    
    @objc func animateView() {
        UIView.animate(withDuration: 0.8,
                       delay: 0.0,
                       options: .curveLinear, animations: {
                        self.footerActivityIndicator.transform = self.footerActivityIndicator.transform.rotated(by: CGFloat(Double.pi))
                       }, completion: { (finished) in
                        if self.timer != nil {
                            self.timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
                        }
                       })
    }
    
    func startTimer() {
        self.footerActivityIndicator.isHidden = false
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.0,
                                         target: self, selector: #selector(self.animateView),
                                         userInfo: nil,
                                         repeats: false)
        }
    }
}
