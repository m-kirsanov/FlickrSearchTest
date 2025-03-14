//
//  Feed.swift
//  FlickrSearch
//
//  Created by Mikhail Kirsanov on 3/13/25.
//

import Foundation

struct Feed: Decodable {
    let items: [FeedItem]
}
