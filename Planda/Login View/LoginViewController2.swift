//
//  LoginViewController.swift
//  Planda
//
//  Created by Prince Carter on 4/30/20.
//  Copyright © 2020 Planda. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore
import MaterialComponents
import FBSDKLoginKit
import SkyFloatingLabelTextField

class LoginViewController2:
UIViewController,
UITextFieldDelegate,
UIGestureRecognizerDelegate {
    
    var firebaseAuth = Auth.auth()
    var signInText = UILabel()
    var errorLabel = UILabel()
    var emailTF = SkyFloatingLabelTextField()
    var pwTF = SkyFloatingLabelTextField()
    var loginBtn = MDCButton()
    var dontHaveAnAccountLabel = UILabel()
    var signUpBtn = MDCButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupToHideKeyboardOnTapOnView()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        view.backgroundColor = .white
        setupSignInText()
        setupErrorLabel()
        setupUserNameTF()
        setupPWTF()
        setupLoginBtn()
        
//        setupAccountLabel()
        loadSubviews()
        setupConstraints()
    }
    
    @objc fileprivate func goToLoginView(_ sender: AnyObject) {
        performSegue(withIdentifier: "loadLoginView", sender: self)
    }
    
    
    @objc fileprivate func goToSignUpView(_ sender: AnyObject) {
        performSegue(withIdentifier: "goToSignUpView", sender: self)
    }
    
    func setupSignInText(){
        signInText = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
        signInText.font = .boldSystemFont(ofSize: 48)
        signInText.textColor = .black
        signInText.numberOfLines = 0
        signInText.sizeToFit()
        signInText.lineBreakMode = .byClipping;
        signInText.text = "Sign in with your Planda account."
    }
    
    func setupErrorLabel() {
        errorLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        errorLabel.isHidden = true
        errorLabel.numberOfLines = 0
        errorLabel.textColor = .white
        errorLabel.font = .boldSystemFont(ofSize: 18)
        errorLabel.sizeToFit()
    }
    
    func setupUserNameTF() {
        emailTF = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 10, width: 200, height: 45))
        emailTF.keyboardType = UIKeyboardType.emailAddress
        emailTF.selectedLineHeight = 2.0
        emailTF.selectedLineColor = .black
        emailTF.selectedTitleColor = .black
        emailTF.tintColor = .black
        emailTF.titleColor = .black
        emailTF.lineColor = .black
        emailTF.textColor = .black
        emailTF.disabledColor = .black
        emailTF.font = .systemFont(ofSize: 20)
        emailTF.delegate = self
        emailTF.attributedPlaceholder = NSAttributedString(string: "Planda Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func setupPWTF() {
        pwTF = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 10, width: 200, height: 45))
        pwTF.isSecureTextEntry = true
        pwTF.autocorrectionType = .no
        pwTF.selectedLineHeight = 2.0
        pwTF.selectedLineColor = .black
        pwTF.selectedTitleColor = .black
        pwTF.tintColor = .black
        pwTF.titleColor = .black
        pwTF.lineColor = .black
        pwTF.textColor = .black
        pwTF.disabledColor = .black
        pwTF.font = .systemFont(ofSize: 20)
        pwTF.delegate = self
        pwTF.attributedPlaceholder = NSAttributedString(string: "Planda Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func textFieldsAreValid() -> Bool {
        if emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            || pwTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return false
        }
        return true
    }
    
    @objc fileprivate func loginAndShowHome(_ sender: AnyObject) {
        self.errorLabel.isHidden = true
        if (textFieldsAreValid()) {
            Auth.auth().signIn(withEmail: emailTF.text!, password: pwTF.text!) { (result, error) in
                if error != nil {
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = "There was an error signing in."
                } else {
                    print("User successfully authenticated!")
                    self.performSegue(withIdentifier: "loginAndGoHome", sender: self)
                }
            }
        } else {
            errorLabel.isHidden = false
            errorLabel.text = "Please fill in all fields!"
        }
    }
    
    func setupLoginBtn(){
        loginBtn = MDCButton(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
        loginBtn.isUppercaseTitle = true
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.setTitleColor(plandaColor, for: .init())
        loginBtn.backgroundColor = .white
        loginBtn.addTarget(self, action: #selector(loginAndShowHome), for: .touchUpInside)
    }
    
//    func setupAccountLabel(){
//        func setupAgreementLabel(){
//            agreementText = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
//            agreementText.text = "Don't have a"
//            agreementText.font = UIFont.systemFont(ofSize: 10)
//            agreementText.textColor = .white
//            agreementText.numberOfLines = 0
//        }
//    }
    
    func loadSubviews() {
        /// Load everything in the correct order
        self.view.addSubview(signInText)
        view.addSubview(errorLabel)
        self.view.addSubview(emailTF)
        self.view.addSubview(pwTF)
        self.view.addSubview(loginBtn)
//        self.view.addSubview(dontHaveAnAccountLabel)
    }
    
    func setupConstraints() {
        /// Welcome message constraints
        signInText.translatesAutoresizingMaskIntoConstraints = false
        signInText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        signInText.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        signInText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.topAnchor.constraint(equalTo: signInText.bottomAnchor, constant: 20).isActive = true
        errorLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        errorLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        emailTF.translatesAutoresizingMaskIntoConstraints = false
        emailTF.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 20).isActive = true
        emailTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        emailTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        pwTF.translatesAutoresizingMaskIntoConstraints = false
        pwTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        pwTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        pwTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 20).isActive = true
        
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        loginBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        loginBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}
