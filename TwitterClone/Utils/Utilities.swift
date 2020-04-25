//
//  Utilities.swift
//  TwitterClone
//
//  Created by Muhammat Fandi Mayuso on 25/4/20.
//  Copyright © 2020 Muhammat Fandi Mayuso. All rights reserved.
//

import UIKit

class Utilities {
    
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let imageView = UIImageView()
        imageView.image = image
        
        view.addSubview(imageView)
        imageView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)
        imageView.setDimensions(width: 24, height: 24)
        
        view.addSubview(textField)
        textField.anchor(left: imageView.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8,  paddingRight: 8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        
        view.addSubview(dividerView)
        dividerView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingRight: 8, height: 0.75)
        
        return view
    }
    
    func textField(withPlaceholder placeHolder: String) -> UITextField {
        
        let textField = UITextField()
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        return textField
    }
    
}
