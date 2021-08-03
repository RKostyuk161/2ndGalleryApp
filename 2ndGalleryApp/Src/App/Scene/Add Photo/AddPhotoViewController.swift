//
//  AddPhotoViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 11.06.2021.
//

import UIKit
import AVFoundation
import Photos
import RxSwift


class AddPhotoViewController: UIViewController,
                              UINavigationControllerDelegate {
    
    var imagePicker: UIImagePickerController!
    var router: AddPhotoRouter!
    var isCameraAccessed = false
    var isPhoneLibraryAccessed = false
    var disposeBag = DisposeBag()

    
    @IBOutlet weak var imagePerview: UIImageView!
    @IBAction func nextButton(_ sender: Any) {
        nextButtonAction()
    }
    @IBAction func addPhotoButton(_ sender: UIButton) {
        addBottomAction()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddPhotoConfigurator().configure(view: self)
    }
    
    func phoneLibAccessCheck() {
        let checkStatus = PHPhotoLibrary.authorizationStatus()
        if checkStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                self.isPhoneLibraryAccessed = (status == .denied) ? false : true
            })
        } else if checkStatus == .denied {
            PHPhotoLibrary.requestAuthorization({status in
                self.isPhoneLibraryAccessed = (status == .denied) ? false : true
            })
        } else {
            self.isPhoneLibraryAccessed = true
        }
        switch isPhoneLibraryAccessed {
        case true:
            pushCameraPicker(isCameraPicker: false)
        case false:
            DispatchQueue.main.async {
                self.addAlertToAddPhotos(alertTitle: R.string.alert.noAccessMessage(),
                                         buttonOneMessage: R.string.alert.okMessage(),
                                         buttonTwoMessage: R.string.alert.settingsMessage(),
                                         view: self)
            }
        }
    }
    
    func cameraAccessCheck() {
        switch isCameraAccessed {
        case false:
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                self.isCameraAccessed = (response) ? true : false
                switch response {
                case true:
                    DispatchQueue.main.async {
                        self.pushCameraPicker(isCameraPicker: true)
                    }
                case false:
                    DispatchQueue.main.async {
                        self.addAlertToAddPhotos(alertTitle: R.string.alert.noAccessMessage(),
                                                 buttonOneMessage: R.string.alert.okMessage(),
                                                 buttonTwoMessage: R.string.alert.settingsMessage(),
                                                 view: self)
                    }
                }
            }
        case true:
            DispatchQueue.main.async {
                self.pushCameraPicker(isCameraPicker: true)
            }
        }
    }
    
    func pushCameraPicker(isCameraPicker: Bool) {
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate = self
        switch isCameraPicker {
        case true:
            self.imagePicker.sourceType = .camera
        default:
            self.imagePicker.sourceType = .photoLibrary
        }
        self.imagePicker.allowsEditing = true
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    func nextButtonAction() {
        guard let image = imagePerview.image else {
            self.addInfoModule(alertTitle: R.string.alert.noImageMessage(),
                               alertMessage: nil,
                               buttonMessage: R.string.alert.okMessage())
            return
        }
        router.onpen(image: image)
    }
}
