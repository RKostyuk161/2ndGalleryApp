//
//  ViewController.swift
//  2ndGalleryApp
//
//  Created by Роман on 10.06.2021.
//

import UIKit
import RxSwift
import RxNetworkApiClient

class StartViewController: UIViewController {
    
    @IBAction func signInButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "SignIn", bundle: nil).instantiateViewController(identifier: "SignInViewController") as! SignInViewController
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiClientImp.defaultInstance(host: Config.apiEndpoint)
        let path = ApiClientImp.defaultInstance(host: Config.apiEndpoint)
        print("\(path)")
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.navigationBar.backgroundColor = nil
        let request = ExtendedApiRequest<ImageEntities>.getGalleryRequest(page: 1, limit: 10, currentCollection: .new)
//        print("my REQUES IS OGM GMGMGMGMGMGMGMMGMMG \()")
    }
    
//    public func getMoreNews() -> Completable {
//        return .deferred {
//            .andThen(ExtendedApiRequest<ImageEntities>.getGalleryRequest(page: 1, limit: 10, currentCollection: .new))
//                .do(onSuccess: { [unowned self] result in
//                    self.updateCacheIfNeed(items: result.items)
//                    self.currentPage += 1
//                    self.totalItemsCount = result.totalItems
//                    self.items.append(contentsOf: result.items)
//                    self.source.onNext(self.items)
//                    self.isLoadingInProcess = false
//                }, onError: { error in
//                    self.isLoadingInProcess = false
//                    print("PaginationSourceUseCase: catch error =", error.localizedDescription)
//                })
//                .asCompletable()
//        }

//    }
}

