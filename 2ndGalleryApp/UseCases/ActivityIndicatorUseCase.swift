//
//  ActivityIndicatorUseCase.swift
//  2ndGalleryApp
//
//  Created by Роман on 17.06.2021.
//

import UIKit

class ActivityIndicatorUseCase: UIViewController {
    
    @objc static func animateView(loadView: UIImageView, timer: Timer?) {
        var timer = timer
        let imageView = loadView
        UIView.animate(withDuration: 0.8,
                       delay: 0.0,
                       options: .curveLinear, animations: {
            imageView.transform = imageView.transform.rotated(by: CGFloat(Double.pi))
        },
                       completion: { (finished) in
            if timer != nil {
                timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
            }
        })
    }
    static func startTimer(loadView: UIImageView, timer: Timer?) {
        var timer = timer
        let imageView = loadView
        loadView.isHidden = false
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
        }
    }
    static func stopTimer(timer: Timer?) {
        var timer = timer
            timer?.invalidate()
            timer = nil
        }
}
