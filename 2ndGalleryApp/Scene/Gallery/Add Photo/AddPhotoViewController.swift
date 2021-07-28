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
                              UIImagePickerControllerDelegate,
                              UINavigationControllerDelegate {
    
    var imagePicker: UIImagePickerController!
    var router: AddPhotoRouter!
    var isCameraAccessed = false
    var isLibAccessed = false
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
    
    func addFromCamera() {
        cameraAccessRequest()
            .observeOn(MainScheduler.instance)
            .subscribe(onCompleted: {
                if self.isCameraAccessed {
                    self.imagePicker = UIImagePickerController()
                    self.imagePicker.delegate = self
                    self.imagePicker.sourceType = .camera
                    self.imagePicker.allowsEditing = true
                    self.present(self.imagePicker, animated: true, completion: nil)
                } else {
                    Alerts().addAlert(alertTitle: "Error",
                                      alertMessage: "Access denied",
                                      buttonMessage: "Ok",
                                      view: self,
                                      function: { return })
                }
            })
            .disposed(by: disposeBag)
    }
    
    func addFromLib() {
        libAccessRequest()
            .observeOn(MainScheduler.instance)
            .subscribe(onCompleted: {
                if self.isLibAccessed {
                    self.imagePicker = UIImagePickerController()
                    self.imagePicker.delegate = self
                    self.imagePicker.sourceType = .photoLibrary
                    self.imagePicker.allowsEditing = true
                    self.present(self.imagePicker, animated: true, completion: nil)
                } else {
                    Alerts().addAlert(alertTitle: "Error",
                                      alertMessage: "Access denied",
                                      buttonMessage: "Ok",
                                      view: self,
                                      function: { return })
                }
            })
            .disposed(by: disposeBag)
    }
    
    func cameraAccessRequest() -> Observable<Bool> {
        let result = Observable.just(isCameraAccessed)
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            self.isCameraAccessed = (response) ? true : false
        }
        return result
    }
    
    func libAccessRequest() -> Observable<Bool> {
        let result = Observable.just(isLibAccessed)
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                self.isLibAccessed = (status == .denied) ? false : true
                return
            })
            return result
        } else if photos == .denied {
            PHPhotoLibrary.requestAuthorization({status in
                self.isLibAccessed = (status == .denied) ? false : true
                return
            })
            return result
        }
        self.isLibAccessed = true
        return result
    }
    
    func addBottomAction() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

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

                actionSheet.addAction(cameraAction)
                actionSheet.addAction(libAction)
                actionSheet.addAction(cancelAction)
                self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[.originalImage] as? UIImage
        imagePicker.dismiss(animated: true, completion: nil)
        imagePerview.image = chosenImage
    }
    
    func nextButtonAction() {
        guard let image = imagePerview.image else {
            Alerts().addAlert(alertTitle: "No image",
                              alertMessage: nil,
                              buttonMessage: "Ok",
                              view: self)
            return
        }
        router.onpen(image: image)
    }
}
