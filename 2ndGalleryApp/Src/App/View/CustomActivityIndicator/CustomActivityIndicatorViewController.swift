//
//  CustomActivityIndicatorViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 14.07.2021.
//

import UIKit

class CustomActivityIndicatorViewController: UIViewController {
    
    var config: CustomActivityIndicatorConfigurator!
        
    var timer: Timer?
    
    @IBOutlet weak var customActiviyIndicatorImage: UIImageView!
    @IBOutlet weak var customActivityIndicatorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.config = CustomActivityIndicatorConfigurator(view: self)
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer()
    }
    
    @objc func animateView() {
        UIView.animate(withDuration: 0.8,
                       delay: 0.0,
                       options: .curveLinear, animations: {
                        self.customActiviyIndicatorImage.transform = self.customActiviyIndicatorImage.transform.rotated(by: CGFloat(Double.pi))
                       }, completion: { (finished) in
                        if self.timer != nil {
                            self.timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
                        }
                       })
    }
    
    func startTimer() {
        self.customActivityIndicatorView.isHidden = false
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        self.customActivityIndicatorView.isHidden = true
        
    }
    
    func dismiss() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
