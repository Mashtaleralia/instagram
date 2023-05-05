//
//  StoreManager.swift
//  instagram
//
//  Created by Admin on 04.04.2023.
//


import FirebaseStorage
import Foundation

public class StorageManager {
    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    public func uploadUserPost(model: UserPost, completion: (Result<URL, Error>) -> Void) {
        
    }
    
    public enum IGStorageManageError: Error {
        case failedToDownload
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, IGStorageManageError>) -> Void) {
        bucket.child(reference).downloadURL(completion: { url , error in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(url))
        })
    }
}
