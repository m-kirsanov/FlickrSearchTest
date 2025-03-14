//
//  FlickrFeedRemoteDataSource.swift
//  FlickrSearch
//
//  Created by Mikhail Kirsanov on 3/13/25.
//

import Foundation

enum FlickrError: Error {
    case decodingError
    case invalidUrl
    case internalError
}

protocol FlickrFeedRemoteDataSourceProtocol {
    func getFeed(_ searchString: String) async throws -> Result<Feed, FlickrError>
}

final class FlickrFeedRemoteDataSource: FlickrFeedRemoteDataSourceProtocol {
    func getFeed(_ searchString: String) async throws -> Result<Feed, FlickrError> {
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(searchString)"
        
        guard let url = URL(string: urlString) else {
            return .failure(.invalidUrl)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            let feed = try decoder.decode(Feed.self, from: data)
            return .success(feed)
        } catch {
            return .failure(.decodingError)
        }
    }
}
