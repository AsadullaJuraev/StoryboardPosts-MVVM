//
//  EditPresenter.swift
//  StoryboardPosts MVP
//
//  Created by Asadulla Juraev on 09/11/21.
//

import Foundation
import Bond

class EditViewModel {
    
    var controller: BaseViewController!
    
    func apiCallPost(id: Int, completion: @escaping (Post)->Void){
        controller?.showProgress()
        AFHttp.get(url: AFHttp.API_POST_SINGLE + String(id), params: AFHttp.paramsPostWith(id: id), handler: { response in
            self.controller?.hideProgress()
            switch response.result {
            case .success:
                let decode = try! JSONDecoder().decode(Post.self, from: response.data!)
                completion(decode)
            case let .failure(error):
                print(error)
                completion(Post())
            }
        })
    }
   
    func apiEditPost(id: Int, post: Post, completion: @escaping (Bool) -> Void) {
        controller?.showProgress()
        AFHttp.put(url: AFHttp.API_POST_UPDATE + String(id), params: AFHttp.paramsPostUpdate(post: post)) { response in
            self.controller?.hideProgress()
            switch response.result {
            case .success:
                print("SUCCESS")
                completion(true)
            case let .failure(error):
                print(error)
                completion(false)
            }
        }
    }
}
