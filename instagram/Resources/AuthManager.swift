//
//  AuthManager.swift
//  instagram
//
//  Created by Admin on 04.04.2023.
//

import FirebaseAuth

public class AuthManager {
    static let shared = AuthManager()
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                Auth.auth().createUser(withEmail: email, password: password) {result, error in
                    guard error == nil && result != nil else {
                        // Firebase auth could not create account
                        completion(false)
                        return
                    }
                //insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) {inserted in
                        if inserted {
                            completion(true)
                        } else {
                            completion(false)
                            return
                        }
                    }
            }
            
            } else {
                completion(false)
            }
    }
}
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        } else if let username = username {
            print(username)
        }
    }
    public func logOut(completion: ((Bool) -> ())) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch {
            print(error)
            completion(false)
            return
        }
        
    }
}
