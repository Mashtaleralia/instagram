//
//  LoginViewController.swift
//  instagram
//
//  Created by Admin on 04.04.2023.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    struct Constants {
        static let cornerRadius = 8.0
    }
    
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        return field
    }()

    private let passwordField: UITextField =  {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
     
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
      return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        header.backgroundColor = .red
        let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backgroundImageView)
        return header
    }()
    
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
            return
        }
        guard var backgroundView = headerView.subviews.first as? UIView else {
            return
        }
        
        let logoLabel = UILabel()
        logoLabel.text = "Cringestagram"
        headerView.addSubview(logoLabel)
        logoLabel.adjustsFontSizeToFitWidth = true
        
        logoLabel.font = UIFont(name: "Avenir-Light", size: 30.0)
        logoLabel.textColor = .white
        logoLabel.frame = CGRect(x: headerView.width / 4.0, y: headerView.safeAreaInsets.top, width: headerView.width, height: headerView.height - view.safeAreaInsets.top)
    }
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let policyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("New User? Create an account", for: .normal )
        button.setTitleColor(.label, for: .normal)
        return button
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        view.backgroundColor = .systemBackground
        usernameEmailField.delegate = self
        passwordField.delegate = self
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        policyButton.addTarget(self, action: #selector(didTapPolicyButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(x: 0, y: 0.0, width: view.width, height: view.height / 3.0)
        usernameEmailField.frame = CGRect(x: 25, y: headerView.bottom + 10, width: view.width - 50, height: 52.0)
        passwordField.frame = CGRect(x: 25, y: usernameEmailField.bottom + 10, width: view.width - 50, height: 52.0)
        loginButton.frame = CGRect(x: 25, y: passwordField.bottom + 10, width: view.width - 50, height: 52.0)
        createAccountButton.frame = CGRect(x: 25, y: loginButton.bottom + 10, width: view.width - 50, height: 52.0)
        termsButton.frame = CGRect(x: 10, y: view.height - view.safeAreaInsets.bottom - 100, width: view.width - 20, height: 50)
        policyButton.frame = CGRect(x: 10, y: view.height - view.safeAreaInsets.bottom - 50, width: view.width - 20, height: 50)
        configureHeaderView()
    }
    
    private func addSubviews() {
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(headerView)
        view.addSubview(termsButton)
        view.addSubview(policyButton)
        view.addSubview(createAccountButton)
    }
    @objc func didTapLoginButton() {
        usernameEmailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty, let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
                return
            }
        var username: String?
        var email: String?
        
        //login functionality
        if usernameEmail.contains("@") && usernameEmail.contains(".") {
            // email
            email = usernameEmail
        } else {
            // username
            username = usernameEmail
        }
        AuthManager.shared.loginUser(username: username,
                                     email: email,
                                     password: password) { success in
            if success {
                // user logged in
                self.dismiss(animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Log In failed", message: "We were unable to log you in", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        }
    }
    
    
    @objc func didTapTermsButton() {
        guard let url = URL(string: "https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwidj96DypX-AhVQs4sKHSukAawQFnoECBgQAQ&url=https%3A%2F%2Fhelp.instagram.com%2F581066165581870&usg=AOvVaw2vymhpbd4WF-QqPCqUvKJb") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
     
    @objc func didTapPolicyButton() {
        guard let url = URL(string: "https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwidj96DypX-AhVQs4sKHSukAawQFnoECBgQAQ&url=https%3A%2F%2Fhelp.instagram.com%2F581066165581870&usg=AOvVaw2vymhpbd4WF-QqPCqUvKJb") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    
    @objc func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            textField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didTapLoginButton()
        }
        return true
    }
   
}
