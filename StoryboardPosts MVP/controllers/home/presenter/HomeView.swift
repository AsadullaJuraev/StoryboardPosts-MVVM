//
//  HomeView.swift
//  StoryboardPosts MVP
//
//  Created by Asadulla Juraev on 09/11/21.
//

import Foundation

protocol HomeView{
    func onLoadPosts(posts: [Post])
    func onPostDelete(deleted: Bool)
}
