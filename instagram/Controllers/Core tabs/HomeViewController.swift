//
//  ViewController.swift
//  instagram
//
//  Created by Admin on 04.04.2023.
//
import FirebaseAuth
import UIKit

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IGPostTableViewCell.self, forCellReuseIdentifier: IGPostTableViewCell.identifier)
        tableView.register(IGPostHeaderTableViewCell.self, forCellReuseIdentifier: IGPostHeaderTableViewCell.identifier)
        tableView.register(IGPostActionsTableViewCell.self, forCellReuseIdentifier: IGPostActionsTableViewCell.identifier)
        tableView.register(IGPostGeneralTableViewCell.self, forCellReuseIdentifier: IGPostGeneralTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        createMockModels()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    private func createMockModels() {
        let user = User(username: "joe", bio: "", name: (first: "", last: ""), birthDate: Date(), gender: .male, counts: UserCount(followers: 1, followinng: 1, posts: 1), joinDate: Date(), ProfilePhoto: URL(string: "https://www.google.com")!)
        let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "https://www.google.com")!, postURL: URL(string: "https://www.google.com")!, caption: nil, likeCount: [], comments: [], createdDate: Date(), taggedUsers: [], owner: user)
        var comments = [PostComment]()
        
        for x in 0 ..< 2 {
            comments.append(PostComment(identifier: "\(x)", userName: "@jenny", text: "This is the best post I have seen", createdDate: Date(), likes: []))
        }
        for x in 0 ..< 5 {
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                                    post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                                                    actions: PostRenderViewModel(renderType: .actions(provider: "")),
                                                    comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            feedRenderModels.append(viewModel)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       handleNotAuthenticated()
        // Check Auth Status
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func handleNotAuthenticated() {
        if Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
            // show log in
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x/4 : ((x - (x%4))/4)
            model = feedRenderModels[position]
        }
        
        let subSection = x%4
        
        if subSection == 0 {
            return 1
        } else if subSection == 1 {
            return 1
        } else if subSection == 2 {
            return 1
        } else if subSection == 3 {
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments): return comments.count > 2 ? 2 : comments.count
            case .header, .actions, .primaryContent: return 0
            
            }
            
        }
        /*
            switch renderModels[section].renderType {
            case .actions(_):
                return 1
            case .comments(let comments):
                return comments.count > 4 ? 4 : comments.count
            case .primaryContent(_):
                return 1
            case.header(_):
                return 1
            
            
            } */
        return 0
           
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count*4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x/4 : ((x - (x%4))/4)
            model = feedRenderModels[position]
        }
        
        let subSection = x%4
        
        if subSection == 0 {
            
            switch model.header.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGPostHeaderTableViewCell.identifier, for: indexPath) as! IGPostHeaderTableViewCell
                return cell
            case .comments, .actions, .primaryContent: return UITableViewCell()
            }
        } else if subSection == 1 {
            let postModel = model.post
            switch postModel.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGPostTableViewCell.identifier, for: indexPath) as! IGPostTableViewCell
                return cell
            case .header, .actions, .comments: return UITableViewCell()
            }
        } else if subSection == 2 {
            let actionModel = model.actions
            switch actionModel.renderType {
            case .actions(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGPostActionsTableViewCell.identifier, for: indexPath) as! IGPostActionsTableViewCell
                return cell
            case .header, .comments, .primaryContent: return UITableViewCell()
            }
        } else if subSection == 3 {
            let commentModel = model.comments
            switch commentModel.renderType {
            case .comments(let comment):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGPostGeneralTableViewCell.identifier, for: indexPath) as! IGPostGeneralTableViewCell
                return cell
            case .header, .actions, .primaryContent: return UITableViewCell()
            }
        }
       
        return UITableViewCell()
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        
        if subSection == 0 {
            return 70
        } else if subSection == 1 {
            return tableView.width
        } else if subSection == 2 {
            return 60
        } else if subSection == 3 {
            return 50
        }
        
            return 0
  
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view: UIView = {
            let view = UIView()
            view.backgroundColor = .cyan
            return view
        }()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
      let subSection = section % 4
        return subSection == 3 ? 70 : 0
    }
}
