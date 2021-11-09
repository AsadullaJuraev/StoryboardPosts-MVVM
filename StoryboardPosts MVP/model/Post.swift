//
//  Posts.swift
//  StoryboardPosts MVP
//
//  Created by Asadulla Juraev on 09/11/21.
//

import Foundation

struct Post: Decodable{
    var id: String? = ""
    var title: String? = ""
    var body: String? = ""
    
    init(){
        
    }
    
    init(title: String, body: String){
        self.title = title
        self.body = body
    }
}
