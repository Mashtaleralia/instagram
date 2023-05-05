//
//  SettingsViewController.swift
//  instagram
//
//  Created by Admin on 04.04.2023.
//

import UIKit
import SafariServices

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}

final class SettingsViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    private var data = [[SettingCellModel]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureModels()
        tableView.frame = view.bounds
        
    }
    private func configureModels() {
       
        data.append([SettingCellModel(title: "Edit Profile") { [weak self] in
            self?.didTapEditProfile()
        }, SettingCellModel(title: "Invite friends") { [weak self] in
            self?.didTapInviteFriends()
        }, SettingCellModel(title: "Save Original Posts") { [weak self] in
            self?.didTapSaveOriginalPosts()
        }])
        data.append([SettingCellModel(title: "Terms of service") { [weak self] in
            self?.openURL(.terms)
        },
        SettingCellModel(title: "Privacy policy") { [weak self] in
            self?.openURL(.privacy)
        },
        SettingCellModel(title: "Help / feedback") { [weak self] in
            self?.openURL(.help)
                    }])
        data.append([SettingCellModel(title: "Log Out") {[weak self] in
            self?.didTapLogOut()
        }])
    }
    
    enum SettingsURLType {
        case terms, privacy, help
    }
    
    private func openURL(_ type: SettingsURLType) {
        let urlString: String
        switch type {
            case .terms: urlString = "https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjV8f7zypX-AhVv_SoKHevYDXIQFnoECAoQAQ&url=https%3A%2F%2Fhelp.instagram.com%2F581066165581870&usg=AOvVaw2vymhpbd4WF-QqPCqUvKJb"
            case .privacy: urlString = "https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwiu3O-SvaL-AhXN-yoKHVuECxQQFnoECAwQAQ&url=https%3A%2F%2Fhelp.instagram.com%2F196883487377501&usg=AOvVaw15hrM4viwTBD-6ZJKIhwOK"
            case .help: urlString = "https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwiW6_O4vaL-AhUNqYsKHddSDOIQFnoECBAQAQ&url=https%3A%2F%2Fhelp.instagram.com%2Fsearch&usg=AOvVaw1nojuJtW7grUnmi5_qmaqV"
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
         
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
    }
    
    private func didTapSaveOriginalPosts() {
        
    }
    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    } 
    
    private func didTapInviteFriends() {
        
    }
    private func didTapLogOut() {
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { _ in   AuthManager.shared.logOut(completion: {success in
            DispatchQueue.main.async {
                if success {
                    let vc = LoginViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true) {
                        self.navigationController?.popToRootViewController(animated: false)
                        self.tabBarController?.selectedIndex = 0
                    }
                }
                else {
                    fatalError("Could not log out user")
                }
                        }
                    })
                }))
            actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
            present(actionSheet, animated: true)
        }
    }

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        data[indexPath.section][indexPath.row].handler()
    }
}
