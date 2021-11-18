//
//  EditViewController.swift
//  StoryboardPosts MVP
//
//  Created by Asadulla Juraev on 09/11/21.
//

import UIKit

class EditViewController: BaseViewController{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var viewModel = EditViewModel()
    var PostID: String = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.controller = self
        viewModel.apiCallPost(id: Int(PostID)!, completion: { post in
            self.initViews(post: post)
        })
    }
    
    @IBAction func buttonSend(_ sender: Any) {
        viewModel.apiEditPost(id: Int(PostID)!, post: Post(title: titleTextField.text!, body: bodyTextView.text!), completion: { status in
            if status{
                self.dismiss(animated: false, completion: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            }else{
                // error message
            }
        })
    }
    
    func initViews(post: Post) {
        bodyLabel.text = "Body"
        titleLabel.text = "Title"
        DispatchQueue.main.async {
            self.bodyTextView.text = post.body!
            self.titleTextField.text = post.title!
        }
    }
    
}
