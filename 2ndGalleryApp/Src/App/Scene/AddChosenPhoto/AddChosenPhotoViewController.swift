//
//  AddChosenPhotoViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 18.07.2021.
//

import UIKit

class AddChosenPhotoViewController: UIViewController {
    
    var presenter: AddChosenPhotoPresenter!

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageToAdd: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarButtons()
        self.imageToAdd.image = presenter.image
        nameTextField.delegate = self
        descriptionTextField.delegate = self
    }

    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveImage() {
        presenter.addPhoto(image: presenter.image,
                           name: nameTextField.text ?? "",
                           description: descriptionTextField.text ?? "")
    }
    
    func addNavBarButtons() {
        let cancelButton = UIBarButtonItem.init(
              title: "",
              style: .done,
              target: self,
            action: #selector(back)
        )
        cancelButton.image = R.image.backButton()
        cancelButton.tintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let addButton = UIBarButtonItem.init(
              title: "Add",
              style: .done,
              target: self,
            action: #selector(saveImage)
        )
        addButton.tintColor = #colorLiteral(red: 0.8443242908, green: 0.3406359553, blue: 0.6639499068, alpha: 1)
        self.navigationItem.rightBarButtonItem = addButton
    }
}
