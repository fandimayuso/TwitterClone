//
//  LoginController.swift
//  TwitterClone
//
//  Created by Muhammat Fandi Mayuso on 25/4/20.
//  Copyright © 2020 Muhammat Fandi Mayuso. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    
    private let logoImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "TwitterLogo")
        
        return imageView
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
    
    private let emailTextField: UITextField = {
        
        let textField = Utilities().textField(withPlaceholder: "Email")
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        
        let textField = Utilities().textField(withPlaceholder: "Password")
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    
    func configureUI() {
        
        view.backgroundColor = .twitterBlue
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 16, paddingRight: 16)
        
    }
    
}
