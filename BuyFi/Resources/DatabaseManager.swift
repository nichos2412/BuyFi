//
//  DatabaseManager.swift
//  BuyFi
//
//  Created by XCodeClub on 2021-10-02.
//

import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    
    ///inserts new user data to database
   
    /// - Parameters
    ///     - email: String representing email
    ///     -username: Strong representing username
    ///     -Completion Async call back for result if database entry is successful
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        let key = email.safeDatabaseKey()

        
        database.child(key).setValue(["username": username])  { error, _ in
            if error == nil {
                //succeeded
                completion(true)
                return
            }
            else {
                //Failed
                completion(false)
                return
        }
        }
    }

}
