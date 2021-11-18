//
//  CreateViewController.swift
//  StoryboardPosts MVP
//
//  Created by Asadulla Juraev on 09/11/21.
//

import UIKit

class CreateViewController: BaseViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var viewModel = CreateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.controller = self
        initViews()
    }

    func initViews(){
        titleLabel.text = "Title"
        bodyLabel.text = "Body"

        let add = UIImage(named: "ic_send")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
    }

    @objc func rightTapped(){
        if titleField.text != "" && bodyTextView.text != "" {
            viewModel.apiCreatePost(post: Post(title: titleField.text!, body: bodyTextView.text!)) { result in
                if result {
                    self.navigationController?.popViewController(animated: true)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                }else{
                    
                }
            }
            
        }
    }
    
}
