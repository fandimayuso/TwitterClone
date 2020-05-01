//
//  RegistrationController.swift
//  TwitterClone
//
//  Created by Muhammat Fandi Mayuso on 25/4/20.
//  Copyright © 2020 Muhammat Fandi Mayuso. All rights reserved.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    private let plusPhotoButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: image, textField: emailTextField)
        
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
        
        return view
    }()
    
    private lazy var fullnameContainerView: UIView = {
        
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: image, textField: fullnameTextField)
        
        return view
    }()
    
    private lazy var usernameContainerView: UIView = {
        
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: usernameTextField)
        
        return view
    }()
    
    private let emailTextField: UITextField = {
        
        let textField = Utilities().textField(withPlaceholder: "Email")
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        
        let textField = Utilities().textField(withPlaceholder: "Password")
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    private let fullnameTextField: UITextField = {
        
        let textField = Utilities().textField(withPlaceholder: "Full Name")
        
        return textField
    }()
    
    private let usernameTextField: UITextField = {
        
        let textField = Utilities().textField(withPlaceholder: "Username")
        
        return textField
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        
        let button = Utilities().attributeButton("Already have an account?", " Log In")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        
        return button
    }()
    
    private let registrationButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Actions
    
    @objc func handleRegistration() {
        
        guard let profileImage = profileImage else { return }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        
        // Convert profile image to data object
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        
        // Create unique id for image profile
        let filename = NSUUID().uuidString
        
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        
        // Upload image profile to storage
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            
            // Download profile image url for updating user information
            storageRef.downloadURL { (url, error) in
                
                if let error = error {
                    print("DEBUG: Error is \(error.localizedDescription)")
                    return
                }
                
                guard let profileImageUrl = url?.absoluteString else { return }
                
                // Authen
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    
                    if let error = error {
                        print("DEBUG: Error is \(error.localizedDescription)")
                        return
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    
                    // Create dictionary for updating user information to database
                    let values = ["email": email,
                                  "username": username,
                                  "fullname": fullname,
                                  "profileImageUrl": profileImageUrl]
                    
                    // Update user information to database
                    REF_USERS.child(uid).updateChildValues(values) { (error, ref) in
                        print("DEBUG: Successfully updated user information")
                    }
                }
            }
        }
    }
    
    @objc func handleAddProfilePhoto() {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleShowLogin() {
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        view.backgroundColor = .twitterBlue
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        plusPhotoButton.setDimensions(width: 128, height: 128)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullnameContainerView, usernameContainerView, registrationButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
    }
    
}

// MARK: - UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        
        plusPhotoButton.layer.cornerRadius = 128 / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3
        plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
}
