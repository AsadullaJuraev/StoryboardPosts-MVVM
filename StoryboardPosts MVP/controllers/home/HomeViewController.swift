//
//  HomeViewController.swift
//  StoryboardPosts MVP
//
//  Created by Asadulla Juraev on 09/11/21.
//

import UIKit

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, HomeView {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: Array<Post> = Array()
    var presenter: HomePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(doThisWhenNotify(notification:)), name: NSNotification.Name(rawValue: "load"), object: nil)
        initView()
        
    }
    
    func initView(){
        initNavigation()
        tableView.delegate = self
        tableView.dataSource = self
        
        presenter = HomePresenter()
        presenter.homeView = self
        presenter.controller = self
        presenter?.apiPostList()
    }

    func onLoadPosts(posts: [Post]) {
        if posts.count > 0 {
            refreshTableView(posts: posts)
        }else{
            // error
        }
    }
    
    func onPostDelete(deleted: Bool) {
        if deleted {
            presenter?.apiPostList()
        }else{
            // error
        }
    }
    
    func refreshTableView(posts: [Post]) {
        self.items = posts
        self.tableView.reloadData()
    }
    
    func initNavigation(){
        let refresh = UIImage(named: "ic_refresh")
        let add = UIImage(named: "ic_add")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "Post list"

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .gray
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        // Customizing our navigation bar
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func callCreateViewController(){
        let vc = CreateViewController(nibName: "CreateViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callEditViewController(id: String){
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        vc.PostID = id
        let navigationController = UINavigationController(rootViewController: vc)
        
        self.present(navigationController, animated: true, completion: nil)
    }

    @objc func leftTapped(){
        presenter?.apiPostList()
    }
    
    @objc func rightTapped(){
        callCreateViewController()
    }

    @objc func doThisWhenNotify(notification : NSNotification) {
        //update tableview

        presenter?.apiPostList()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("PostTableViewCell", owner: self, options: nil)?.first as! PostTableViewCell
        
        cell.bodyLabel.text = item.body
        cell.titleLabel.text = item.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeCompleteContextualAction(forRowAt: indexPath, post: items[indexPath.row])
        ])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeDeleteContextualAction(forRowAt: indexPath, post: items[indexPath.row])
        ])
    }
    
    //MARK: - Contextual Actions
    
    private func makeDeleteContextualAction(forRowAt: IndexPath, post: Post) -> UIContextualAction{
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            
            completion(true)
            self.presenter?.apiPostDelete(post: post)
        }
    }
    
    private func makeCompleteContextualAction(forRowAt: IndexPath, post: Post) -> UIContextualAction{
        return UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView, completion) in
            
            completion(true)
            self.callEditViewController(id: post.id!)
            
        }
    }
    
}
