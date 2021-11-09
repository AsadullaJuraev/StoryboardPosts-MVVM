//
//  EditPresenter.swift
//  StoryboardPosts MVP
//
//  Created by Asadulla Juraev on 09/11/21.
//

import Foundation

protocol EditPresenterProtocol {
    func apiCallPost(id: Int)
    func apiEditPost(id: Int, post: Post)
}

class EditPresenter: EditPresenterProtocol{
    var editView : EditView!
    var controller: BaseViewController!
    
    func apiCallPost(id: Int){
        controller?.showProgress()
        AFHttp.get(url: AFHttp.API_POST_SINGLE + String(id), params: AFHttp.paramsPostWith(id: id), handler: { response in
            self.controller?.hideProgress()
            switch response.result {
            case .success:
                let decode = try! JSONDecoder().decode(Post.self, from: response.data!)
                self.editView.onCallPost(post: decode)
            case let .failure(error):
                print(error)
                self.editView.onCallPost(post: Post())
            }
        })
    }
   
    func apiEditPost(id: Int, post: Post) {
        controller?.showProgress()
        AFHttp.put(url: AFHttp.API_POST_UPDATE + String(id), params: AFHttp.paramsPostUpdate(post: post)) { response in
            self.controller?.hideProgress()
            switch response.result {
            case .success:
                print("SUCCESS")
                self.editView.onEditPost(status: true)
            case let .failure(error):
                print(error)
                self.editView.onEditPost(status: false)
            }
        }
    }
}
