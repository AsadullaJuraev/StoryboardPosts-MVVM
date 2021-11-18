//
//  HomeViewModel.swift
//  StoryboardPosts MVP
//
//  Created by Asadulla Juraev on 09/18/21.
//

import Foundation
import Bond

class HomeViewModel{
    var controller: BaseViewController!
    var items = Observable<[Post]>([])
    
    func apiPostList(){
        controller?.showProgress()
        AFHttp.get(url: AFHttp.API_POST_LIST, params: AFHttp.paramsEmpty()) { response in
            self.controller?.hideProgress()
            switch response.result {
            case .success:
                let posts = try! JSONDecoder().decode([Post].self, from: response.data!)
                self.items.value = posts
            case let .failure(error):
                print(error)
            }
        }
    }

    func apiPostDelete(post: Post, completion: @escaping (Bool) -> Void){
        controller?.showProgress()
        AFHttp.del(url: AFHttp.API_POST_DELETE + post.id!, params: AFHttp.paramsEmpty(), handler: { response in
            self.controller?.hideProgress()
            switch response.result {
            case .success:
                print(response.result)
                completion(true)
            case let .failure(error):
                print(error)
                completion(false)
            }
        })
    }
    
    
}
