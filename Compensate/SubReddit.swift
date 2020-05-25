//
//  SubReddit.swift
//  Compensate
//
//  Created on 23.5.2020.
//  Copyright © 2020 Compensate. All rights reserved.
//

import Foundation

// MARK: - SubReddit
struct SubReddit: Codable {
    let data: SubRedditData
}

// MARK: - SubRedditData
struct SubRedditData: Codable {
    let posts: [Post]
    
    enum CodingKeys: String, CodingKey {
        case posts = "children"
    }
}

// MARK: - Child
struct Post: Codable {
    let content: Content
    
    enum CodingKeys: String, CodingKey {
        case content = "data"
    }
}

// MARK: - DataElement
struct Content: Codable {
    let title: String
    let selftext: String?
    let ups: Int
    let downs: Int
    let linkFlairText: String?
    let thumbnail: String?
    let thumbnailHeight: Int?
    let thumbnailWidth: Int?
    let created: Int64
    let id: String
    let author: String?
    let numComments: Int
    let permalink: String
    let url: String?
    let preview: Preview?
    let stickied: Bool
}

// MARK: - Preview
struct Preview: Codable {
    let images: [Image]
    let enabled: Bool
}

// MARK: - Image
struct Image: Codable {
    let source: ImageSource
}

// MARK: - ResizedIcon
struct ImageSource: Codable {
    let url: String
    let width: Int
    let height: Int
}
