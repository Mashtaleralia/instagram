//
//  DatabaseManager.swift
//  instagram
//
//  Created by Admin on 04.04.2023.
//

import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    /// Check if username is available
    /// -   Parameters
    ///     - email: String representing email
    ///      - username: String representing username
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeDataBaseKey()).setValue(["username": username],  withCompletionBlock: {error, _ in
            if error == nil {
                completion(true)
                return
            } else {
                completion(false)
                return
            }
        })
    }
  
  
}
