//
//  AuthService.swift
//  TwitterClone
//
//  Created by Muhammat Fandi Mayuso on 1/5/20.
//  Copyright © 2020 Muhammat Fandi Mayuso. All rights reserved.
//

import UIKit
import Firebase

struct AuthCredentials {
     let email: String
     let password: String
     let fullname: String
     let username: String
     let profileImage: UIImage
}

struct AuthService {
    
    static let shared = AuthService()
    
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        
        let email = credentials.email
        let password = credentials.password
        let fullname = credentials.fullname
        let username = credentials.username
        
        // Convert profile image to data object
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        
        // Create unique id for image profile
        let filename = NSUUID().uuidString
        
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        
        // Upload image profile to storage
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            
            // Download profile image url from storage for updating user information
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
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                }
            }
        }
    }
}
