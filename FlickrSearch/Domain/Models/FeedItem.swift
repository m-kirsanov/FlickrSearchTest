//
//  FeedItem.swift
//  FlickrSearch
//
//  Created by Mikhail Kirsanov on 3/13/25.
//

import Foundation

struct FeedItem: Identifiable, Decodable {
    var id: Int {
        return imageUrl.hashValue
    }
    let title: String
    let author: String
    let imageUrl: String
    let tags: String
    let publishedDate: Date
    
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case tags
        case publishedDate = "published"
        case media
        
        enum MediaKeys: String, CodingKey {
            case imageUrl = "m"
        }
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.author = try container.decode(String.self, forKey: .author)
        self.tags = try container.decode(String.self, forKey: .tags)
        self.publishedDate = try container.decode(Date.self, forKey: .publishedDate)
                                                    
        let mediaContainer = try container.nestedContainer(
            keyedBy: CodingKeys.MediaKeys.self,
            forKey: .media
        )
        
        self.imageUrl = try mediaContainer.decode(String.self, forKey: .imageUrl)
    }
    
    init(title: String, 
         author: String,
         imageUrl: String,
         tags: String,
         publishedDate: Date) {
        self.title = title
        self.author = author
        self.imageUrl = imageUrl
        self.tags = tags
        self.publishedDate = publishedDate
    }
}
