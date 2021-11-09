//
//  EditView.swift
//  StoryboardPosts MVP
//
//  Created by Asadulla Juraev on 09/11/21.
//

import Foundation

protocol EditView{
    func initViews()
    func onCallPost(post: Post)
    func onEditPost(status: Bool)
}
