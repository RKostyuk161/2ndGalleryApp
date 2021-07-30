//
//  CustomActivityIndicatorConfigurator.swift
//  2ndGalleryApp
//
//  Created by Роман on 22.07.2021.
//

import Foundation
import UIKit

class CustomActivityIndicatorConfigurator  {
    
    var view: CustomActivityIndicatorViewController!
    
    init(view: CustomActivityIndicatorViewController) {
        self.view = view
    }
    
    static func open() {
        guard let view = R.storyboard.customActivityIndicatorStoryBoard.customActivity(),
              let rootVc = AppDelegate.shared.window?.rootViewController else { return }
        view.providesPresentationContextTransitionStyle = true
        view.definesPresentationContext = true
        view.modalPresentationStyle = .overCurrentContext
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            rootVc.present(view, animated: true, completion: nil)
        }
    }
    
    func dissmisss() {
        self.view.dismiss()
    }
}
