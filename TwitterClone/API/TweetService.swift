//
//  TweetService.swift
//  TwitterClone
//
//  Created by Muhammat Fandi Mayuso on 3/5/20.
//  Copyright © 2020 Muhammat Fandi Mayuso. All rights reserved.
//

import UIKit
import Firebase

struct TweetService {
    
    static let shared = TweetService()
    
    func uploadTweet(caption: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid": uid,
                      "timestamp": Int(NSDate().timeIntervalSince1970), // Date in second
                      "likes": 0,
                      "retweets": 0,
                      "caption": caption] as [String : Any]
        
        // Auto generate unique tweet id and update to database
        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        
        var tweets = [Tweet]()
        
        // Get all tweets from database
        REF_TWEETS.observe(.childAdded) { snapshot in
            
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            let tweetID = snapshot.key  // Get tweet id
            let tweet = Tweet(tweetID: tweetID, dictionary: dictionary)
            
            tweets.append(tweet)
            
            completion(tweets)
        }
    }
}
