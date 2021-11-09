//
//  EditViewController.swift
//  StoryboardPosts MVP
//
//  Created by Asadulla Juraev on 09/11/21.
//

import UIKit

class EditViewController: BaseViewController, EditView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var PostID: String = "1"
    var post : Post = Post()
    var presenter: EditPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = EditPresenter()
        presenter.editView = self
        presenter.controller = self
        presenter?.apiCallPost(id: Int(PostID)!)
    }
    
    @IBAction func buttonSend(_ sender: Any) {
        presenter?.apiEditPost(id: Int(PostID)!, post: Post(title: titleTextField.text!, body: bodyTextView.text!))
    }
    
    func initViews() {
        bodyLabel.text = "Body"
        titleLabel.text = "Title"
        DispatchQueue.main.async {
            self.bodyTextView.text = self.post.body!
            self.titleTextField.text = self.post.title!
        }
    }
    
    func onCallPost(post: Post) {
        if post != nil {
            self.post = post
            initViews()
        }else{
            // error message
        }
    }
    
    func onEditPost(status: Bool) {
        if status{
            self.dismiss(animated: false, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }else{
            // error message
        }
    }

}
