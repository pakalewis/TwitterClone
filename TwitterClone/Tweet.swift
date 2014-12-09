//
//  Tweet.swift
//  TwitterClone
//
//  Created by Parker Lewis on 10/6/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import Foundation
import UIKit

class Tweet {
    
    var text : String
    var id : String
    var retweetCount : String
    var favoriteCount : String
    var username : String
    var screen_name : String
    var avatarURLString : String
    var profileImage : UIImage?
    var placeholderProfileImage = UIImage(named: "default")
    var followersCount : String
    
    
    
    init (tweetInfo : NSDictionary) {
        self.text = tweetInfo["text"] as String
        self.id = tweetInfo["id_str"] as String

        let retweet_count = tweetInfo["retweet_count"] as Int
        self.retweetCount = String(retweet_count)
        
        let favorite_count = tweetInfo["favorite_count"] as Int
        self.favoriteCount = String(favorite_count)
        
        // store user dictionary part of the JSON
        let userDictionary = tweetInfo["user"] as NSDictionary
        self.username = userDictionary["name"] as String
        self.screen_name = userDictionary["screen_name"] as String
        self.avatarURLString = userDictionary["profile_image_url"] as String
        
        let followers_count = userDictionary["followers_count"] as Int
        self.followersCount = String(followers_count)
    }
 
    
    
    
    class func parseJSONDataIntoTweets(rawJSONData : NSData) -> [Tweet]? {
        var error : NSError?
        if let JSONArray = NSJSONSerialization.JSONObjectWithData(rawJSONData, options: nil, error: &error) as? NSArray {
            
            var tweets = [Tweet]()
            
            for JSONDictionary in JSONArray {
                if let tweetDictionary = JSONDictionary as? NSDictionary {
                    var newTweet = Tweet(tweetInfo: tweetDictionary)
                    tweets.append(newTweet)
                }
            }
            
            // sort array of tweets alphabetically (not used any more)
            // looks at first item in array ($0) and compares to next item ($1)
            // tweets.sort({$0.text < $1.text})
            return tweets
        }
        return nil
    }
}