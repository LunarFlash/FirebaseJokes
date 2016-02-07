//
//  DataService.swift
//  FirebaseJokes
//
//
//  Copyright © 2016 Yi Wang. All rights reserved.
//

// This DataService class is a service class that interacts with Firebase. To read and write data, we need to create a Firebase database reference with the Firebase URL. The base URL is the URL of our Joke database.


import Foundation
import Firebase

class DataService {
    
    // Note: Initializing a database reference doesn’t mean that you create an actual database connection to the Firebase server. Data is not fetched until a read or write operation is invoked.
    static let dataService = DataService()  // instantiate new DataService class
    
    // private URLs
    private var _BASE_REF = Firebase(url: "\(BASE_URL)")
    private var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    private var _JOKE_REF = Firebase(url: "\(BASE_URL)/jokes")
    
    // expose private URLs 
    
    var BASE_REF: Firebase {
        return _BASE_REF
    }
    
    var USER_REF: Firebase {
        return _USER_REF
    }
    
    var CURRENT_USER_REF: Firebase {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        
        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
        
        return currentUser!
    }
    
    var JOKE_REF: Firebase {
        return _JOKE_REF
    }
    
    // To save data to the Firebase database, you can just call the setValue method. In the above code, it’ll save the user object to the users database reference under the given uid child node (e.g. /users/1283834/).
    func createNewAccount(uid: String, user: Dictionary<String, String>) {
        
        // A User is born.
        
        USER_REF.childByAppendingPath(uid).setValue(user)
    }

    
    func createNewJoke(joke: Dictionary<String, AnyObject>){
        
        // save the joke
        // JOKE_REF is the parent of the new Joke: "jokes"
        // childByAutoId() saves thejoke and gives it its own ID
        
        let firebaseNewJoke = JOKE_REF.childByAutoId()
        
        // setValue() save to Firebase
        firebaseNewJoke.setValue(joke)
        
        //  Again, you can save the joke with the Firebase method, setValue(). But note that we use the Joke database reference and call the childByAutoId method. When childByAutoId is invoked, Firebase generates a timestamp-based, unique ID for each joke. This ensures that each joke is associated with an unique ID.
    }
    
    
}