//
//  AuthManager.swift
//  BuyFi
//
//  Created by XCodeClub on 2021-10-02.
//

import FirebaseAuth
public class AuthManager {
    
    static let shared = AuthManager()
    
    // Public
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {

        //check if username is available
        
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
            
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                guard error == nil, result != nil else {
                    // Firebase auth could not create account
                    completion(false)
                    return
                }
            //Insert into database
                DatabaseManager.shared.insertNewUser(with: email, username: username) {
                    inserted in
                    if inserted {
                        completion(true)
                        return
                }
                else {
                    //failed to insert into database
                    completion(false)
                    return
                }
                    
            }
            }
            
        }
            else {
                // either username or email does not exist
                completion(false)
            }
    }
    
    }
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
           //email login
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                completion(false)
                    return
        }
        completion(true)
            }
        }
                else if let username = username {
        //username login
                    print(username)
                }
}
    ///Attempt to logout FireBase user
    public func logOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch {
            print(error)
            completion(false)
            return
           
        }
    }
    
}
