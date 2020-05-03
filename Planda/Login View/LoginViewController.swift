//
//  LoginViewController.swift
//  Planda
//
//  Created by Prince Carter on 4/30/20.
//  Copyright © 2020 Planda. All rights reserved.
//

import UIKit
import MaterialComponents
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    var loginBtn = MDCButton()
    var welcomeText = UILabel()
    var plandaLogo = UIImageView()
    var fbLoginBtn = FBLoginButton()
    var signupBtn = MDCButton()
    var agreementText = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let token = AccessToken.current,
            !token.isExpired {
            // User is logged in, do work such as go to next view controller.
        }
    
        view.backgroundColor = plandaColor
        setupWelcomeMessage()
        setupLoginBtn()
        setupFBBtn()
        setupSignupBtn()
        setupAgreementLabel()
        loadSubviews()
        setupConstraints()
    }
    
    @objc fileprivate func dropDown(_ sender: AnyObject) {
        performSegue(withIdentifier: "loadHomeView", sender: self)
    }
    
    func setupWelcomeMessage(){
        welcomeText = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
        welcomeText.font = .boldSystemFont(ofSize: 64)
        welcomeText.textColor = .white
        welcomeText.numberOfLines = 0
        welcomeText.sizeToFit()
        welcomeText.lineBreakMode = .byClipping;
        welcomeText.text = "Welcome To Planda."
    }
    
    func setupLoginBtn(){
        loginBtn = MDCButton(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
        loginBtn.isUppercaseTitle = true
        loginBtn.setTitle("Log In", for: .normal)
        loginBtn.backgroundColor = .clear
        loginBtn.addTarget(self, action: #selector(dropDown), for: .touchUpInside)
    }
    
    func setupPlandaLogo(){
        plandaLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
        plandaLogo.image = UIImage(named: "plandaIcon")
    }
    
    func setupFBBtn(){
        fbLoginBtn.permissions = ["public_profile", "email"]
        fbLoginBtn.center = view.center
    }
    
    func setupSignupBtn(){
        signupBtn = MDCButton(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
        signupBtn.isUppercaseTitle = true
        signupBtn.setTitle("Sign Up", for: .normal)
        signupBtn.setBackgroundColor(.clear)
    }
    
    func setupAgreementLabel(){
        agreementText = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
        agreementText.text = "By clicking on \"Sign Up\" you agree to accept Planda's terms & conditions policy"
        agreementText.font = UIFont.systemFont(ofSize: 10)
        agreementText.textColor = .white
        agreementText.numberOfLines = 0
    }
    
    func loadSubviews() {
        /// Load everything in the correct order
        self.view.addSubview(welcomeText)
        self.view.addSubview(loginBtn)
        self.view.addSubview(plandaLogo)
        self.view.addSubview(fbLoginBtn)
        self.view.addSubview(signupBtn)
        self.view.addSubview(agreementText)
    }
    
    func setupConstraints() {
        
        //Constraints
        /// Login button constraints
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        loginBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        /// Welcome message constraints
        welcomeText.translatesAutoresizingMaskIntoConstraints = false
        welcomeText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        welcomeText.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 60).isActive = true
        welcomeText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        /// User Agreement constraints
        agreementText.translatesAutoresizingMaskIntoConstraints = false
        agreementText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        agreementText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        agreementText.heightAnchor.constraint(equalToConstant: 80).isActive = true
        agreementText.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        
        /// Sign up button constraints
        signupBtn.translatesAutoresizingMaskIntoConstraints = false
        signupBtn.leadingAnchor.constraint(equalTo: fbLoginBtn.leadingAnchor, constant: 0).isActive = true
        signupBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        signupBtn.bottomAnchor.constraint(equalTo: agreementText.topAnchor, constant: 10).isActive = true
        
//        /// Sign up with Facebook button constraints
        fbLoginBtn.translatesAutoresizingMaskIntoConstraints = false
        fbLoginBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        fbLoginBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        fbLoginBtn.bottomAnchor.constraint(equalTo: signupBtn.topAnchor, constant: -20).isActive = true
        fbLoginBtn.heightAnchor.constraint(equalToConstant: 800).isActive = true
        
    }

}
