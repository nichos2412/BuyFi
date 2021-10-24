//
//  StorageManager.swift
//  BuyFi
//
//  Created by XCodeClub on 2021-10-02.
//

import FirebaseStorage
import Foundation

public class StorageManager {
    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
        
    public enum IGStorageManagerError: Error {
        case failedToDownload
    }
    
    public func uploadUserPhotoPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {
        
    }
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, IGStorageManagerError>) ->Void) {
        bucket.child(reference).downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
            return
    }
            completion(.success(url))
        })
}
}

public enum UserPostType {
    case photo, video
}


/// represents userpost

public struct UserPost {
    let postType: UserPostType
    let identifier: String
    let thumbnailImage: URL
    let postURL: URL // either video or url or full resolution photo
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    
}

struct PostLike {
    let username: String
    let postIdentifier: String
}

struct CommentLike {
    let username: String
    let commentIdentifier: String



}
struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
    
}
