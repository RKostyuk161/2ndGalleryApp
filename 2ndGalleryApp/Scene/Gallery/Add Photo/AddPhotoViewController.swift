//
//  AddPhotoViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 11.06.2021.
//

import UIKit
import AVFoundation

class AddPhotoViewController: UIViewController,
                              UIImagePickerControllerDelegate,
                              UINavigationControllerDelegate {
    
    var imagePicker: UIImagePickerController!
    var router: AddPhotoRouter!

    @IBAction func nextButton(_ sender: Any) {
        guard let image = imagePerview.image else {
            Alerts().addAlert(alertTitle: "No image",
                              alertMessage: nil,
                              buttonMessage: "Ok",
                              view: self)
            return
        }
        router.onpen(image: image)
    }
    @IBOutlet weak var imagePerview: UIImageView!
    @IBAction func addPhotoButton(_ sender: UIButton) {
        addBottomAction()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddPhotoConfigurator().configure(view: self)
    }
    
    func addFromCamera() {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func addFromLib() {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func addBottomAction() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

                // Create your actions - take a look at different style attributes
                let cameraAction = UIAlertAction(title: "Use Camera", style: .default) {
                    (action) in
                    self.addFromCamera()
                }

                let libAction = UIAlertAction(title: "Take from Gallery", style: .default) {
                    (action) in
                    self.addFromLib()
                }

                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {_ in
                    
                }

                // Add the actions to your actionSheet
                actionSheet.addAction(cameraAction)
                actionSheet.addAction(libAction)
                actionSheet.addAction(cancelAction)
                // Present the controller
                self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[.originalImage] as? UIImage
        imagePicker.dismiss(animated: true, completion: nil)
        imagePerview.image = chosenImage
    }
}
