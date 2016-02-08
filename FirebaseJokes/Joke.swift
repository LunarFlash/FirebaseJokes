//
//  Joke.swift
//  FirebaseJokes
//
//  Created by Matthew Maher on 1/23/16.
//  Copyright © 2016 Yi Wang. All rights reserved.
//

import Foundation
import Firebase

class Joke {
    
    private var jokeRef: Firebase!
    private(set) var jokeKey: String!
    private(set) var jokeText: String!
    private(set) var jokeVotes: Int!
    private(set) var username: String!
    
    
    // init new joke
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self.jokeKey = key
        
        // Within the Joke, or Key, the following properties are children
        
        if let votes = dictionary["votes"] as? Int {
            self.jokeVotes = votes
        } else {
            self.jokeVotes = 0
        }
        
        if let joke = dictionary["jokeText"] as? String {
            self.jokeText = joke
        }
        
        if let user = dictionary["author"] as? String {
            self.username = user
        } else {
            self.username = ""
        }
        
        // The above properties are assigned to their key
        self.jokeRef = DataService.dataService.JOKE_REF.childByAppendingPath(self.jokeKey)
        
    }
    
    
    
    
    
    func addSubtractVote(addVote: Bool) {
        
        if addVote {
            jokeVotes = jokeVotes + 1
        } else {
            jokeVotes = jokeVotes - 1
        }
        
        // Save the new vote total.
        
        jokeRef.childByAppendingPath("votes").setValue(jokeVotes)
        
    }
    
}