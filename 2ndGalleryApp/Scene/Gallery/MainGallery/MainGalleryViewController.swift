//
//  MainGalleryViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import UIKit

class MainGalleryViewController: UIViewController {

    var positionOfNewGallery: IndexPath? = nil
    var positionOfPopularGallery: IndexPath? = nil
    var presenter: MainGalleryPresenter!
    var setNumberOfCellsInRow: Int = 2
    let collectionViewRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    } ()
    var lastElement = false
    
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var gallerySegmentControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
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
        presenter.subscribeOnSearch()
        presenter.getFullGalleryRequest(isNewCollection: presenter.currentCollection)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewLayoutMarginsDidChange() {
        self.view.viewWithTag(1)?.removeFromSuperview()

        self.setSegmentControl()
        setNumberOfCellsInRow = UIDevice.current.orientation.isLandscape ? 4 : 2

    }    

    @objc func refresh(sender: UIRefreshControl) {
        presenter.refresh()
        presenter.getFullGalleryRequest(isNewCollection: presenter.currentCollection)
    }
    
    func setupViewIfNeed() {
        setSegmentControl()
        gallerySegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.selected)
        guard self.presenter == nil else { return }
        let currentCollection = self.gallerySegmentControl.selectedSegmentIndex
        MainGalleryConfigurator().config(view: self, currentCollection: currentCollection, currentGalleryState: 0)
        let galleryCellName = R.nib.mainGalleryCollectionViewCell.name
        self.galleryCollectionView.register(UINib(nibName: galleryCellName,
                                                  bundle: nil),
                                            forCellWithReuseIdentifier: galleryCellName)
        self.galleryCollectionView.dataSource = self
        self.galleryCollectionView.delegate = self
        self.galleryCollectionView.refreshControl = collectionViewRefreshControl
        
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
    
    
}
