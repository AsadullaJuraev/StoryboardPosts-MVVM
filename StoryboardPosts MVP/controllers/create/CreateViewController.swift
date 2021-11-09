//
//  CreateViewController.swift
//  StoryboardPosts MVP
//
//  Created by Asadulla Juraev on 09/11/21.
//

import UIKit

class CreateViewController: BaseViewController, CreateView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var presenter: CreatePresenter!
    var item = Post()
    
    override func viewDidLoad() {
        super.viewDidLoad()

      initViews()
    }

    func initViews(){
        presenter = CreatePresenter()
        presenter.createView = self
        presenter.controller = self
        titleLabel.text = "Title"
        bodyLabel.text = "Body"

        let add = UIImage(named: "ic_send")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
    }

    @objc func rightTapped(){
        if titleField.text != "" && bodyTextView.text != "" {
            presenter?.apiCreatePost(post: Post(title: titleField.text!, body: bodyTextView.text!))
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
    }
    
    func onCreated(status: Bool) {
        if status {
            self.navigationController?.popViewController(animated: true)
        }else{
            // something went wrong! 😐
        }
        
    }

}
