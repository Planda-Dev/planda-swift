//
//  SignUpViewController.swift
//  Planda
//
//  Created by Prince Carter on 4/30/20.
//  Copyright © 2020 Planda. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import MaterialComponents
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

class SignUpViewController2:
UIViewController,
UIGestureRecognizerDelegate,
UITextFieldDelegate {

    var firebaseAuth = Auth.auth()
    var errorLabel = UILabel()
    var almostThereLabel = UILabel()
    var emailTF = SkyFloatingLabelTextField()
    var usernameTF = SkyFloatingLabelTextField()
    var pwTF = SkyFloatingLabelTextField()
    var confirmTF = SkyFloatingLabelTextField()
    var startBtn = MDCButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        view.backgroundColor = plandaColor
        setupToHideKeyboardOnTapOnView()
        setupAlmostThereLabel()
        setupErrorLabel()
        setupUserNameTF()
        setupEmailTF()
        setupPWTF()
        setupConfirmPWTF()
        setupStartBtn()
        loadSubviews()
        setupConstraints()
    }
    
    func setupAlmostThereLabel() {
        almostThereLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        almostThereLabel.numberOfLines = 0
        almostThereLabel.textColor = .white
        almostThereLabel.font = .boldSystemFont(ofSize: 40)
        almostThereLabel.sizeToFit()
        almostThereLabel.text = "Almost There."
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
        usernameTF = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 10, width: 200, height: 45))
        usernameTF.keyboardType = UIKeyboardType.emailAddress
        usernameTF.selectedLineHeight = 2.0
        usernameTF.selectedLineColor = .white
        usernameTF.selectedTitleColor = .white
        usernameTF.tintColor = .white
        usernameTF.titleColor = .white
        usernameTF.lineColor = .white
        usernameTF.textColor = .white
        usernameTF.disabledColor = .white
        usernameTF.font = .systemFont(ofSize: 20)
        usernameTF.delegate = self
        usernameTF.attributedPlaceholder = NSAttributedString(string: "Choose a touristy username!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func setupEmailTF() {
        emailTF = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 10, width: 200, height: 45))
        emailTF.keyboardType = UIKeyboardType.emailAddress
        emailTF.selectedLineHeight = 2.0
        emailTF.selectedLineColor = .white
        emailTF.selectedTitleColor = .white
        emailTF.tintColor = .white
        emailTF.titleColor = .white
        emailTF.lineColor = .white
        emailTF.textColor = .white
        emailTF.disabledColor = .white
        emailTF.font = .systemFont(ofSize: 20)
        emailTF.delegate = self
        emailTF.attributedPlaceholder = NSAttributedString(string: "What is your email address?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func setupPWTF() {
        pwTF = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 10, width: 200, height: 45))
        pwTF.isSecureTextEntry = true
        pwTF.autocorrectionType = .no
        pwTF.selectedLineHeight = 2.0
        pwTF.selectedLineColor = .white
        pwTF.selectedTitleColor = .white
        pwTF.tintColor = .white
        pwTF.titleColor = .white
        pwTF.lineColor = .white
        pwTF.textColor = .white
        pwTF.disabledColor = .white
        pwTF.font = .systemFont(ofSize: 20)
        pwTF.delegate = self
        pwTF.attributedPlaceholder = NSAttributedString(string: "Choose a unique password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func setupConfirmPWTF() {
        confirmTF = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 10, width: 200, height: 45))
        confirmTF.isSecureTextEntry = true
        confirmTF.selectedLineHeight = 2.0
        confirmTF.selectedLineColor = .white
        confirmTF.selectedTitleColor = .white
        confirmTF.tintColor = .white
        confirmTF.titleColor = .white
        confirmTF.lineColor = .white
        confirmTF.textColor = .white
        confirmTF.disabledColor = .white
        confirmTF.font = .systemFont(ofSize: 20)
        confirmTF.delegate = self
        confirmTF.attributedPlaceholder = NSAttributedString(string: "Confirm your password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }

    func setupStartBtn() {
        startBtn = MDCButton(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
        startBtn.isUppercaseTitle = true
        startBtn.setTitle("Start", for: .normal)
        startBtn.setTitleColor(plandaColor, for: .init())
        startBtn.setBackgroundColor(UIColor.white)
        startBtn.layer.cornerRadius = 5
        startBtn.addTarget(self, action: #selector(showHomeView), for: .touchUpInside)
    }
    
    func loadSubviews() {
        view.addSubview(almostThereLabel)
        view.addSubview(errorLabel)
        view.addSubview(emailTF)
        view.addSubview(usernameTF)
        view.addSubview(pwTF)
        view.addSubview(confirmTF)
        view.addSubview(startBtn)
    }
    
    func setupConstraints() {
        almostThereLabel.translatesAutoresizingMaskIntoConstraints = false
        almostThereLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        almostThereLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        almostThereLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.topAnchor.constraint(equalTo: almostThereLabel.bottomAnchor, constant: 20).isActive = true
        errorLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        errorLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        emailTF.translatesAutoresizingMaskIntoConstraints = false
        emailTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        emailTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        emailTF.topAnchor.constraint(equalTo: almostThereLabel.bottomAnchor, constant: 100).isActive = true
        
        usernameTF.translatesAutoresizingMaskIntoConstraints = false
        usernameTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        usernameTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        usernameTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 20).isActive = true

        pwTF.translatesAutoresizingMaskIntoConstraints = false
        pwTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        pwTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        pwTF.topAnchor.constraint(equalTo: usernameTF.bottomAnchor, constant: 20).isActive = true

        confirmTF.translatesAutoresizingMaskIntoConstraints = false
        confirmTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        confirmTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        confirmTF.topAnchor.constraint(equalTo: pwTF.bottomAnchor, constant: 20).isActive = true

        startBtn.translatesAutoresizingMaskIntoConstraints = false
        startBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        startBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        startBtn.topAnchor.constraint(equalTo: confirmTF.bottomAnchor, constant: 200).isActive = true
        startBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func textFieldsAreValid() -> Bool {
        if emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || usernameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || pwTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  || confirmTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return false
        }
        return true
    }
    
    func passwordsMatch() -> Bool {
        if pwTF.text == confirmTF.text {
            return true
        } else {
            return false
        }
    }
    
    @objc fileprivate func showHomeView(_ sender: AnyObject) {
        if (textFieldsAreValid() && passwordsMatch()) {
            firebaseAuth.createUser(withEmail: emailTF.text!, password: pwTF.text!){ (result, error) in
                if error != nil {
                    print(error!)
                } else {
                    let firebaseDB = Firestore.firestore()
                    firebaseDB.collection("users").addDocument(data: ["first_name":SignUpViewController.GlobalVariables.userFirstName, "last_name":SignUpViewController.GlobalVariables.userLastName,
                        "birthday":SignUpViewController.GlobalVariables.userBirthday,
                        "username":self.usernameTF.text!,
                        "uid":result!.user.uid
                        ]) { (error) in
                        if error != nil {
                            print(error!)
                        }
                    }
                    self.performSegue(withIdentifier: "showHomeView", sender: self)
                }
            }
            errorLabel.isHidden = false
            errorLabel.text = "Success!"
        } else if (!textFieldsAreValid()){
            errorLabel.isHidden = false
            errorLabel.text = "Please enter all fields!"
        } else {
            errorLabel.isHidden = false
            errorLabel.text = "Passwords don't match!"
        }
    }
    
}
