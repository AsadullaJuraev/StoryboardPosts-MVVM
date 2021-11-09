//
//  CreatePresenter.swift
//  StoryboardPosts MVP
//
//  Created by Asadulla Juraev on 09/11/21.
//

import Foundation

protocol CreatePresenterProtocol{
    func apiCreatePost(post: Post)
}

class CreatePresenter : CreatePresenterProtocol{
    
    var createView: CreateView!
    var controller: BaseViewController!
    
    func apiCreatePost(post: Post){
        self.controller?.showProgress()
        AFHttp.post(url: AFHttp.API_POST_CREATE, params: AFHttp.paramsPostCreate(post: post)) { response in
            self.controller?.hideProgress()
            switch response.result {
            case .success:
                print("SUCCESS")
                self.createView.onCreated(status: true)
            case let .failure(error):
                print(error)
                self.createView.onCreated(status: false)
            }
        }
    }
    
    
}
