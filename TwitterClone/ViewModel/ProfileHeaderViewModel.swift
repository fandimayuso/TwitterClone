//
//  ProfileHeaderViewModel.swift
//  TwitterClone
//
//  Created by Muhammat Fandi Mayuso on 9/5/20.
//  Copyright © 2020 Muhammat Fandi Mayuso. All rights reserved.
//

import Foundation

enum ProfileFilterOptions: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    var description: String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Tweets & Replies"
        case .likes: return "Likes"
        }
    }
}
