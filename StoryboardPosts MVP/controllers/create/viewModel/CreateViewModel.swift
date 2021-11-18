//
//  CreatePresenter.swift
//  StoryboardPosts MVP
//
//  Created by Asadulla Juraev on 09/11/21.
//

import Foundation
import Bond

class CreateViewModel{
    
    var controller: BaseViewController!
    
    func apiCreatePost(post: Post, completion: @escaping (Bool) -> Void){
        self.controller?.showProgress()
        AFHttp.post(url: AFHttp.API_POST_CREATE, params: AFHttp.paramsPostCreate(post: post)) { response in
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
