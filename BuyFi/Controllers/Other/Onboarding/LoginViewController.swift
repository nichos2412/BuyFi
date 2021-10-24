//
//  LoginViewController.swift
//  BuyFi
//
//  Created by XCodeClub on 2021-10-01.
//
import SafariServices
import UIKit

struct Constants {
    static let cornerRadius: CGFloat = 8.0
     
 }
 
class LoginViewController: UIViewController {

 
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
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
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        return button
    }()
   
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Or Create an Account", for: .normal)
        return button
    }()

    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        
        let backgroundImageView = UIImageView(image: UIImage(named: "purplegrad"))
        header.addSubview(backgroundImageView)
        
        return header
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self, action: #selector(didTapLoginButton),
                              for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        usernameEmailField.delegate = self
        passwordField.delegate = self
        addSubviews()
        view.backgroundColor = .systemBackground
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        
        // assign frames
        
        headerView.frame = CGRect(x: 0,
                y: 0,
                width: view.width,
                                  height: view.height/3.0)
        
    
        
        usernameEmailField.frame = CGRect(x: 25,
                y: headerView.bottom + 40 ,
                width: view.width-50,
                height: 52.0)
        
    
        passwordField.frame = CGRect(x: 25,
                                     y: usernameEmailField.bottom + 15,
                                          width: view.width-50,
                                          height: 52.0)
    
        loginButton.frame = CGRect(x: 25,
                             y: passwordField.bottom + 15,
                                  width: view.width-50,
                                  height: 52.0)

        createAccountButton.frame = CGRect(x: 25,
                     y: loginButton.bottom + 10,
                          width: view.width-50,
                          height: 52.0)
        
        termsButton.frame = CGRect(
            x: 10,
            y:view.height-view.safeAreaInsets.bottom-100,
            width: view.width-20,
            height: 50
        )
   
        privacyButton.frame = CGRect(
            x: 10,
            y:view.height-view.safeAreaInsets.bottom-50,
            width: view.width-20,
            height: 50
        )
        
        configureHeaderView()
}

    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
            return
            
        }

        guard let backgroundView = headerView.subviews.first else {
            return
            
        }
            backgroundView.frame = headerView.bounds
            
        
        
        
        // Add instagram logo

        let imageView = UIImageView(image: UIImage(named: "textlogo"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4.0,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.width/2.0,
                                 height: headerView.height - view.safeAreaInsets.top)
        
        
    }
    
    
    private func addSubviews() {
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(createAccountButton)
        view.addSubview(privacyButton)
        view.addSubview(headerView)
    
}
  
    
    @objc private func didTapLoginButton() {
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
                  return
              
                  // login functionality
              }
    
        var username: String?
        var email: String?
        
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
           //email
            email = usernameEmail
        }
        else {
            //username
            username = usernameEmail
            
        }
        AuthManager.shared.loginUser(username: username,
                                     email: email,
                                     password: password) { success in
            DispatchQueue.main.async {
            }
        
                if success {
                  // user logged in
                    self.dismiss(animated: true, completion: nil)
                }
                else {
                    //error occured
                    let alert = UIAlertController(title: "Login Error",
                                                  message: "Unable to log in", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
            
        }
    
    
    @objc private func didTapTermsButton() {
    guard let url = URL(string: "https://www.news.com.au") else {
        return
    }
    let vc = SFSafariViewController(url: url)
    present(vc, animated: true)
    }
        
    @objc private func didTapPrivacyButton() {
        guard let url = URL(string: "https://www.news.com.au") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
        
    }
    @objc private func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    
    }



}



extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didTapLoginButton()
        }
    return true
    
    }
    
}


