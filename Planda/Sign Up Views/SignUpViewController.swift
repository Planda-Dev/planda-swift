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

class SignUpViewController:
UIViewController,
UIGestureRecognizerDelegate,
UITextFieldDelegate {
    
    struct GlobalVariables {
        /// User input variables that we store in the database
        static var userFirstName = String()
        static var userLastName = String()
        static var userBirthday = String()
    }
    
    var signUpLabel = UILabel()
    var errorLabel = UILabel()
    var firstNameTF = SkyFloatingLabelTextField()
    var lastNameTF = SkyFloatingLabelTextField()
    var birthdateTF = SkyFloatingLabelTextField()
    var picker = UIDatePicker()
    var nextBtn = MDCButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        view.backgroundColor = .white
        setupToHideKeyboardOnTapOnView()
        setupSignUpTitle()
        setupErrorLabel()
        setupFirstNameTF()
        setupLastNameTF()
        setupBirthdateTF()
        setupNextBtn()
        loadSubviews()
        setupConstraints()
    }
    
    func setupSignUpTitle() {
        signUpLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        signUpLabel.numberOfLines = 0
        signUpLabel.textColor = .black
        signUpLabel.font = .boldSystemFont(ofSize: 40)
        signUpLabel.sizeToFit()
        signUpLabel.text = "Your journey starts here."
    }

    func setupErrorLabel() {
        errorLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        errorLabel.isHidden = true
        errorLabel.numberOfLines = 0
        errorLabel.textColor = .white
        errorLabel.font = .boldSystemFont(ofSize: 18)
        errorLabel.sizeToFit()
    }
    
    func setupFirstNameTF() {
        firstNameTF = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 10, width: 200, height: 45))
        firstNameTF.keyboardType = .alphabet
        firstNameTF.autocapitalizationType  = .words
        firstNameTF.selectedLineHeight = 2.0
        firstNameTF.selectedLineColor = .black
        firstNameTF.selectedTitleColor = .black
        firstNameTF.tintColor = .black
        firstNameTF.titleColor = .black
        firstNameTF.lineColor = .black
        firstNameTF.textColor = .black
        firstNameTF.disabledColor = .black
        firstNameTF.font = .systemFont(ofSize: 20)
        firstNameTF.delegate = self
        firstNameTF.attributedPlaceholder = NSAttributedString(string: "What is your first name?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
    }
    
    func setupLastNameTF() {
        lastNameTF = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 10, width: 200, height: 45))
        lastNameTF.keyboardType = .alphabet
        lastNameTF.autocapitalizationType  = .words
        lastNameTF.selectedLineHeight = 2.0
        lastNameTF.selectedLineColor = .black
        lastNameTF.selectedTitleColor = .black
        lastNameTF.tintColor = .black
        lastNameTF.titleColor = .black
        lastNameTF.lineColor = .black
        lastNameTF.textColor = .black
        lastNameTF.disabledColor = .black
        lastNameTF.font = .systemFont(ofSize: 20)
        lastNameTF.delegate = self
        lastNameTF.attributedPlaceholder = NSAttributedString(string: "What is your last name?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func setupBirthdateTF() {
        birthdateTF = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 10, width: 200, height: 45))
        birthdateTF.selectedLineHeight = 2.0
        birthdateTF.selectedLineColor = .black
        birthdateTF.selectedTitleColor = .black
        birthdateTF.titleColor = .black
        birthdateTF.lineColor = .black
        birthdateTF.textColor = .black
        birthdateTF.disabledColor = .black
        birthdateTF.tintColor = .black
        birthdateTF.font = .systemFont(ofSize: 20)
        birthdateTF.delegate = self
        birthdateTF.attributedPlaceholder = NSAttributedString(string: "When were you born?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)

        birthdateTF.inputAccessoryView = toolbar
        picker.datePickerMode = .date
        birthdateTF.inputView = picker
    }
    
     @objc func doneDatePicker() {
      let formatter = DateFormatter()
      formatter.dateFormat = "MM/dd/yyyy"
      birthdateTF.text = formatter.string(from: picker.date)
      self.view.endEditing(true)
    }

    @objc func cancelDatePicker() {
       self.view.endEditing(true)
     }
    
    func setupNextBtn() {
        nextBtn = MDCButton(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
        nextBtn.isUppercaseTitle = true
        nextBtn.setTitle("Next", for: .normal)
        nextBtn.setTitleColor(.white, for: .init())
        nextBtn.setBackgroundColor(UIColor.black)
        nextBtn.layer.cornerRadius = 5
        nextBtn.addTarget(self, action: #selector(goToNextSignUp), for: .touchUpInside)
    }

    func loadSubviews() {
        /// Load everything in the correct order
        view.addSubview(signUpLabel)
        view.addSubview(errorLabel)
        view.addSubview(firstNameTF)
        view.addSubview(lastNameTF)
        view.addSubview(birthdateTF)
        view.addSubview(nextBtn)
    }
    
    func setupConstraints() {
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        signUpLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        signUpLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 20).isActive = true
        errorLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        errorLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true

        firstNameTF.translatesAutoresizingMaskIntoConstraints = false
        firstNameTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        firstNameTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        firstNameTF.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 100).isActive = true

        lastNameTF.translatesAutoresizingMaskIntoConstraints = false
        lastNameTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        lastNameTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        lastNameTF.topAnchor.constraint(equalTo: firstNameTF.bottomAnchor, constant: 20).isActive = true

        birthdateTF.translatesAutoresizingMaskIntoConstraints = false
        birthdateTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        birthdateTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        birthdateTF.topAnchor.constraint(equalTo: lastNameTF.bottomAnchor, constant: 20).isActive = true

        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        nextBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nextBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        nextBtn.topAnchor.constraint(equalTo: birthdateTF.bottomAnchor, constant: 200).isActive = true
        nextBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    func textFieldsAreValid() -> Bool {
        if firstNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  || birthdateTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return false
        }
        return true
    }
    
    
    @objc fileprivate func goToNextSignUp(_ sender: AnyObject) {
        if (textFieldsAreValid()) {
            errorLabel.isHidden = true
            GlobalVariables.userFirstName = firstNameTF.text!
            GlobalVariables.userLastName = lastNameTF.text!
            GlobalVariables.userBirthday = birthdateTF.text!
            print(GlobalVariables.userFirstName)
            print(GlobalVariables.userLastName)
            print(GlobalVariables.userBirthday)
            performSegue(withIdentifier: "goToNextSignUp", sender: self)
        } else {
            errorLabel.isHidden = false
            errorLabel.text = "Please enter all fields!"
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
