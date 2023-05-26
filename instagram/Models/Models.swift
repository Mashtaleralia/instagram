//
//  Models.swift
//  instagram
//
//  Created by Admin on 13.04.2023.
//

import Foundation


enum Gender {
    case male, female, other
}
public enum UserPostType: String {
    case photo = "Photo"
    case video = "Video"
}
struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
    let ProfilePhoto: URL
}

struct UserCount {
    let followers: Int
    let followinng: Int
    let posts: Int
}
/// Represents a user post
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL
    let caption: String?
    let likeCount: [PostLikes]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [String]
    let owner: User
}

struct PostLikes {
    let username: String
    let postIdentifier: String
}

struct CommentLike {
    let username: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let userName: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
}
