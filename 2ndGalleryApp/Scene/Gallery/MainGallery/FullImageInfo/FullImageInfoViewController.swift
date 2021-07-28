//
//  FullImageInfoViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 16.06.2021.
//

import UIKit
import Kingfisher

class FullImageInfoViewController: UIViewController {
    
    var presenter: FullImageInfoPresenter!

    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptoinLabel: UILabel!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var birthDayUserNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentScrollView.delegate = self
        presenter.setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let cancelButton = UIBarButtonItem.init(
              title: "",
              style: .done,
              target: self,
            action: #selector(back)
        )
        cancelButton.image = R.image.backButton()
        cancelButton.tintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.reloadInputViews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
