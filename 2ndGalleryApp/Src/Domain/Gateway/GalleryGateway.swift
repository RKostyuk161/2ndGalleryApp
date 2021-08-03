//
//  UserGateway.swift
//  2ndGalleryApp
//
//  Created by Роман on 15.06.2021.
//

import Foundation
import RxSwift
import RxNetworkApiClient

class GalleryGateway {
    
    var disposeBag = DisposeBag()
    static var getUrl = "http://gallery.dev.webant.ru/api/photos/"
    static var getFullImageUrl = "http://gallery.dev.webant.ru/media/"
    static var postUrl = ""
    private var todos: [ImageEntities]? = nil
    
    typealias galleryCallback = (_ getInfo: ImageEntities?, _ message: String) -> Void
    typealias ImageCallback = (_ getImage: UIImage, _ message: String) -> Void

    
    
    let apiClient = ApiClientImp.defaultInstance(host: getUrl)
//    let request = ApiRequest<TodoItem> = .request(path: "", method: .get)
    
    private func loadItems() {
//        _ = apiClient.execute(request: .todoList())
//                .observeOn(MainScheduler.instance)
//                .do(onSubscribed: self.refreshControl?.beginRefreshing,
//                    onDispose: self.refreshControl?.endRefreshing)
//                .subscribe(onSuccess: { (todos: [ImageEntities]) in
//                    self.todos = todos
//                    self.tableView.reloadData()
//                }) { (error) in
//                    print("ViewController: error = ", error)
//                    self.showLoadingError()
//                }
    }
    
//    func getRequest(currentUrl: String, numberOfPage: Int, currentCollection: CollectionType, callback: @escaping galleryCallback) {
//        let parametrs: [String : Any]
//
//        switch currentCollection {
//        case .new:
//            parametrs = ["page" : numberOfPage, "limit": 10, "new" : true]
//        case .popular:
//            parametrs = ["page" : numberOfPage, "limit": 10, "new" : false, "popular" : true]
//        }
//
//        RxAlamofire.data(.get, currentUrl, parameters: parametrs)
//            .subscribe { [weak self] response in
//                guard self != nil else { return }
//                do {
//                    let data = try JSONDecoder().decode(ImageEntities.self, from: response)
//                    callback(data, "200")
//                } catch let error {
//                    callback(nil, String(describing: error.localizedDescription.description))
//                }
//
//            } onError: { (error) in
//
//                callback(nil, "no connection")
//            }
//
//            .disposed(by: disposeBag)
//    }
}
