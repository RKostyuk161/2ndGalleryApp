//
//  MainGalleryViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import UIKit

class MainGalleryViewController: UIViewController, UISearchBarDelegate {

    var positionOfNewGallery: IndexPath? = nil
    var positionOfPopularGallery: IndexPath? = nil
    var presenter: MainGalleryPresenter!
    var setNumberOfCellsInRow: Int = 2
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var gallerySegmentControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var galleryLoadActivityIndicator: UIImageView!
    
    @IBAction func galleryActionSegmentControl(_ sender: UISegmentedControl) {
        if gallerySegmentControl.selectedSegmentIndex == 0 {
            gallerySegmentControl.changeUnderlinePosition()
            presenter.currentCollection = .new
            galleryCollectionView.reloadData()
            if let currentpos = positionOfNewGallery {
                galleryCollectionView.scrollToItem(at: currentpos, at: .bottom, animated: false)
            }
        } else {
            gallerySegmentControl.changeUnderlinePosition()
            presenter.currentCollection = .popular
            if presenter.isfistPopularImageRequest {
                presenter.getFullGalleryRequest(isNewCollection: presenter.currentCollection)
            }
            galleryCollectionView.reloadData()
            if let currentpos = positionOfPopularGallery {
                galleryCollectionView.scrollToItem(at: currentpos, at: .centeredHorizontally, animated: false)
            }
        }
    }
    
    var timer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewIfNeed()
        searchBar.delegate = self
        presenter.subscribeOnGalleryRequestResult()
        presenter.getFullGalleryRequest(isNewCollection: presenter.currentCollection)
        
    }
    
    override func viewLayoutMarginsDidChange() {
        self.view.viewWithTag(1)?.removeFromSuperview()

        self.setSegmentControl()
        setNumberOfCellsInRow = UIDevice.current.orientation.isLandscape ? 4 : 2

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
        setSegmentControl()
        gallerySegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.selected)
        guard self.presenter == nil else { return }
        let currentCollection = self.gallerySegmentControl.selectedSegmentIndex
        MainGalleryConfigurator().config(view: self, currentCollection: currentCollection)
        let galleryCellName = R.nib.mainGalleryCollectionViewCell.name
        self.galleryCollectionView.register(UINib(nibName: galleryCellName,
                                                  bundle: nil),
                                            forCellWithReuseIdentifier: galleryCellName)
        self.galleryCollectionView.dataSource = self
        self.galleryCollectionView.delegate = self
        
    }
    
    
    func saveIndexPathToScroll(indexPath: IndexPath){
        switch presenter.currentCollection {
        case .new:
            positionOfNewGallery = indexPath
        default:
            positionOfPopularGallery = indexPath
        }
    }
        
    func setSegmentControl() {
        gallerySegmentControl.addUnderlineForSelectedSegment()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
