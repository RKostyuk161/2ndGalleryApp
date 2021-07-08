//
//  MainGalleryViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import UIKit

class MainGalleryViewController: UIViewController {

    var presenter: MainGalleryPresenterImp!
    var setNumberOfCellsInRow: Int {
        UIDevice.current.orientation.isLandscape ? 4 : 2
        
    }
    

    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var gallerySegmentControl: UISegmentedControl!
    
    @IBOutlet weak var galleryLoadActivityIndicator: UIImageView!
    @IBAction func galleryActionSegmentControl(_ sender: UISegmentedControl) {
        if gallerySegmentControl.selectedSegmentIndex == 0 {
            gallerySegmentControl.changeUnderlinePosition()
            presenter.currentCollection = .new
            galleryCollectionView.reloadData()
            galleryCollectionView.scrollToItem(at: presenter.indexPathToScrollNewCollection, at: .centeredHorizontally, animated: false)
        } else {
            gallerySegmentControl.changeUnderlinePosition()
            presenter.currentCollection = .popular
            if presenter.paginationNumberOfPageOfPopularImages == 1 {
                presenter.getFullGalleryRequest(isNewCollection: presenter.currentCollection)
            }
            galleryCollectionView.reloadData()
            galleryCollectionView.scrollToItem(at: presenter.indexPathToScrollPopularCollection, at: .centeredHorizontally, animated: false)
        }
    }
    
    var timer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSegmentControl()
        setupViewIfNeed()
        presenter.subscribeOnGalleryRequestResult()
        presenter.getFullGalleryRequest(isNewCollection: presenter.currentCollection)

        gallerySegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.selected)
    }
    override func viewDidAppear(_ animated: Bool) {
        
        galleryLoadActivityIndicator.isHidden = true
        stopTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        galleryLoadActivityIndicator.isHidden = false
        startTimer()
    }
    
    @objc func animateView() {
            UIView.animate(withDuration: 0.8,
                           delay: 0.0,
                           options: .curveLinear, animations: {
                self.galleryLoadActivityIndicator.transform = self.galleryLoadActivityIndicator.transform.rotated(by: CGFloat(Double.pi))
            }, completion: { (finished) in
                if self.timer != nil {
                    self.timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
                }
            })
        }
    
    func startTimer() {
        self.galleryLoadActivityIndicator.isHidden = false
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
        }
    }
    
    func stopTimer() {
            timer?.invalidate()
            timer = nil
        }
   
    func setupViewIfNeed() {
        guard self.presenter == nil else { return }
        let currentCollection = self.gallerySegmentControl.selectedSegmentIndex
        MainGalleryConfigurator().config(view: self, currentCollection: currentCollection)
        self.galleryCollectionView.register(UINib(nibName: "MainGalleryCollectionViewCell",
                                                  bundle: nil),
                                            forCellWithReuseIdentifier: "MainGalleryCollectionViewCell")
        self.galleryCollectionView.dataSource = self
        self.galleryCollectionView.delegate = self
        
    }
    
    
    func setSegmentControl() {
        gallerySegmentControl.addUnderlineForSelectedSegment()
    }
    
}
