//
//  Tweet.swift
//  TwitterClone
//
//  Created by Muhammat Fandi Mayuso on 4/5/20.
//  Copyright © 2020 Muhammat Fandi Mayuso. All rights reserved.
//

import Foundation

struct Tweet {
    
    let caption: String
    let tweetID: String
    let uid: String
    let likes: Int
    var timestamp: Date!
    let retweetCount: Int
    
    init(tweetID: String, dictionary: [String: Any]) {
        
        self.tweetID = tweetID
        
        self.caption = dictionary["caption"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.retweetCount = dictionary["retweets"] as? Int ?? 0
        
        // Convert date in second to Date type
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
    }
}
