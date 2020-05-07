//
//  Constants.swift
//  TwitterClone
//
//  Created by Muhammat Fandi Mayuso on 1/5/20.
//  Copyright © 2020 Muhammat Fandi Mayuso. All rights reserved.
//

import Firebase

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")

let REF_TWEETS = DB_REF.child("tweets")