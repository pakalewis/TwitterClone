//
//  HomeTimeLineViewController.swift
//  TwitterClone
//
//  Created by Parker Lewis on 10/6/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit
import Accounts
import Social


class HomeTimeLineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var tweets : [Tweet]?
    var twitterAccount : ACAccount?
    var networkController : NetworkController!
    var refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // make AppDelegate a singleton
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController
        
        
        // load custom cell from nib
        self.tableView.registerNib(UINib(nibName: "CustomTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CustomCell")
        self.tableView.estimatedRowHeight = 75.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        
        
        // talk to network controller and call it's method to fetch initial batch of tweets
        self.networkController.fetchTimeLine(nil, firstTweetID: nil, lastTweetID: nil) { (errorDescription, tweets) -> (Void) in
            if errorDescription != nil {
                // there is a problem
            } else {
                self.tweets = tweets
                self.tableView.reloadData()
            }

        }

        
        // set up pull to refresh action
        self.refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    
    
    // make another network call to get new tweets when the pull down gesture is used
    func refresh() {
        // store the id of the top tweet
        var firstTweet = tweets?[0]
        var firstTweetID = firstTweet?.id
        
        // make network call by passing the first tweet as a parameter
        self.networkController.fetchTimeLine(nil, firstTweetID: firstTweetID, lastTweetID: nil) { (errorDescription, newTweets) -> (Void) in
            if errorDescription != nil {
                // there is a problem
            } else {
                self.tweets = newTweets! + self.tweets!
                self.tableView.reloadData()
            }
        }
        self.refreshControl.endRefreshing()
    }

    
    
    
    //MARK:Tableview Stuff
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // create new cell
        var cell : CustomTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as CustomTableViewCell
        
        // target the appropriate tweet
        let tweet = self.tweets?[indexPath.row]

        // set cell text to be the tweet text
        cell.cellText.text = tweet?.text
        
        // set cell's image (if not yet downloaded, then call method in network controller)
        if tweet?.profileImage != nil {
            cell.cellImage.image = tweet?.profileImage
        } else {
            cell.cellImage.image = tweet?.placeholderProfileImage
            self.networkController.downloadImage(tweet!, completionHandler: { (image) -> Void in
                cell.cellImage.image = image
            })
        }
        return cell
    }
    
    
    
    // cell selected, that tweet is passed to new TweetViewController which is then displayed
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // create new Tweet VC
        var newTweetViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TweetViewController") as TweetViewController
        // pass the appropriate tweet data
        newTweetViewController.tweet = self.tweets?[indexPath.row]
        // push the new VC onto the nav stack
        self.navigationController?.pushViewController(newTweetViewController, animated: true)
    }
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tweets != nil {
            return self.tweets!.count
        } else {
            return 0
        }
    }
    
    
    // set up network request for older tweets when reaching the bottom of the tableview
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        var indexPathToLoadOlderTweets = self.tweets!.count - 5
        if indexPath.row == (indexPathToLoadOlderTweets) {
            // store the id of the last tweet
            var lastTweet = tweets?.last
            var lastTweetID = lastTweet?.id
            
            self.networkController.fetchTimeLine(nil, firstTweetID: nil, lastTweetID: lastTweetID, completionHandler: { (errorDescription, oldTweets) -> (Void) in
                if errorDescription != nil {
                    // there is a problem
                } else {
                    self.tweets = self.tweets! + oldTweets!
                    self.tableView.reloadData()
                }
            })
        }
    }
}
