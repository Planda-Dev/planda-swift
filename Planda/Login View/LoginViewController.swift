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
import FirebaseAuth
import FirebaseFirestore

class LoginViewController:
UIViewController,
LoginButtonDelegate {
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
            performSegue(withIdentifier: "showHome", sender: self)
        }
        
        view.backgroundColor = plandaColor
        setupWelcomeMessage()
        setupLoginBtn()
        setupFBBtn()
        setupSignupBtn()
        loadSubviews()
        setupConstraints()
    }
    
    @objc fileprivate func goToLoginView(_ sender: AnyObject) {
        performSegue(withIdentifier: "loadLoginView", sender: self)
    }
    
    
    @objc fileprivate func goToSignUpView(_ sender: AnyObject) {
        performSegue(withIdentifier: "goToSignUpView", sender: self)
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
        loginBtn.addTarget(self, action: #selector(goToLoginView), for: .touchUpInside)
    }
    
    func setupPlandaLogo(){
        plandaLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
        plandaLogo.image = UIImage(named: "plandaIcon")
    }
    
    func setupFBBtn(){
        fbLoginBtn.delegate = self
        fbLoginBtn.permissions = ["public_profile", "email"]
        fbLoginBtn.center = view.center
        fbLoginBtn.removeConstraints(fbLoginBtn.constraints)
    }
    
    func setupSignupBtn(){
        signupBtn = MDCButton(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
        signupBtn.isUppercaseTitle = true
        signupBtn.setTitle("Register with Email", for: .normal)
        signupBtn.setTitleColor(plandaColor, for: .init())
        signupBtn.setBackgroundColor(.white)
        signupBtn.addTarget(self, action: #selector(goToSignUpView), for: .touchUpInside)
        signupBtn.removeConstraints(signupBtn.constraints)
    }
    
    func setupAgreementLabel(){
        agreementText = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
        agreementText.text = "By clicking on \"Sign Up\" you agree to accept Planda's terms & conditions policy"
        agreementText.font = UIFont.systemFont(ofSize: 12)
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
//        self.view.addSubview(agreementText)
    }
    
    func setupConstraints() {
        
        //Constraints
        /// Login button constraints
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        loginBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        /// Welcome message constraints
        welcomeText.translatesAutoresizingMaskIntoConstraints = false
        welcomeText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        welcomeText.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 60).isActive = true
        welcomeText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
//        /// User Agreement constraints
//        agreementText.translatesAutoresizingMaskIntoConstraints = false
//        agreementText.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
//        agreementText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
//        agreementText.heightAnchor.constraint(equalToConstant: 80).isActive = true
//        agreementText.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        
        /// Sign up button constraints
        signupBtn.translatesAutoresizingMaskIntoConstraints = false
        signupBtn.leftAnchor.constraint(equalTo: fbLoginBtn.leftAnchor, constant: 0).isActive = true
        signupBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        signupBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        signupBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        /// Sign up with Facebook button constraints
        fbLoginBtn.translatesAutoresizingMaskIntoConstraints = false
        fbLoginBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        fbLoginBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        fbLoginBtn.bottomAnchor.constraint(equalTo: signupBtn.topAnchor, constant: -20).isActive = true
        fbLoginBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    let graphRequest = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                  parameters: ["fields": "id, first_name, last_name, name, email"],
                                                  tokenString: AccessToken.current?.tokenString,
                                                  version: nil,
                                                  httpMethod: .get)
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error == nil {
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            Auth.auth().signIn(with: credential) { (authResult, error) in
            if error != nil {

            }
            self.graphRequest.start { (connection, result, error) -> Void in
                if let result = result as? [String:String] {
                    let randomInt = Int.random(in: 100..<9999)
                      let firebaseDB = Firestore.firestore()
                        firebaseDB.collection("users").addDocument(data: [
                          "first_name":result["first_name"]!,
                          "last_name":result["last_name"]!,
                          "birthday":"",
                          "username":String(result["name"]!) + "#" + String(randomInt),
                          "uid":result["id"]!
                          ]) { (error) in
                          if error != nil {
                              print(error!)
                          }
                      }
                    }
                }
            }
            print("Successfully logged with with Facebook!")
            performSegue(withIdentifier: "showHome", sender: self)
        } else {
            print (error?.localizedDescription as Any)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("This user has logged out with Facebook.")
    }
}
