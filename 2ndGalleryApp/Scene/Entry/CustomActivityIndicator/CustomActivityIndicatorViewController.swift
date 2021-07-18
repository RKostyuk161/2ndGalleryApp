//
//  CustomActivityIndicatorViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 14.07.2021.
//

import UIKit

protocol CustomActivityIndicator {
    func startTimer(view: UIView, loader: UIImageView)
    
    func stopTimer(view: UIView, loader: UIImageView)
}

class CustomActivityIndicatorImp: CustomActivityIndicator {
    
    var timer: Timer?
    
    func startTimer(view: UIView, loader: UIImageView) {
        view.isHidden = false
        if timer == nil {
//            timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView(loader: loader)), userInfo: nil, repeats: false)
        }
    }
    
    func stopTimer(view: UIView, loader: UIImageView) {
        view.isHidden = true
        timer?.invalidate()
        timer = nil
    }
    
    @objc func animateView(loader: UIImageView) {
        UIKit.UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveLinear, animations: {
            loader.transform = loader.transform.rotated(by: CGFloat(Double.pi))
        }, completion: { (finished) in
            if self.timer != nil {
                self.timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
            }
        })
    }
}
