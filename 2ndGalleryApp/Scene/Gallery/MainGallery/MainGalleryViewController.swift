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
    var isLastPaginationPage = true
    static var isNeedFlipToProfile = false
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var gallerySegmentControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var errorImage: UIImageView!
    
    
    
    @IBAction func galleryActionSegmentControl(_ sender: UISegmentedControl) {
        presenter.gallerySegmentControlAction()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewIfNeed()
        presenter.subscribeOnGalleryRequestResult()
        presenter.subscribeOnSearch()
        presenter.subscribeOnUserModel()
        presenter.getFullGalleryRequest(isNewCollection: presenter.currentCollection)
        if MainGalleryViewController.isNeedFlipToProfile {
            MainGalleryViewController.isNeedFlipToProfile = false
            self.tabBarController?.selectedIndex = 2
        }
        
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
        self.searchBar.delegate = self
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
    
    func showErrorOnGallery(show: Bool) {
        switch show {
        case true:
            errorImage.isHidden = false

        default:
            errorImage.isHidden = true
        }
    }
}
