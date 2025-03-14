//
//  FlickrFeedRepository.swift
//  FlickrSearch
//
//  Created by Mikhail Kirsanov on 3/13/25.
//

import Foundation

protocol FlickrFeedRepositoryProtocol {
    func getFeed(_ searchString: String) async throws -> Result<Feed, FlickrError>
}

final class FlickrFeedRepository: FlickrFeedRepositoryProtocol {
    private let remoteDataSource: FlickrFeedRemoteDataSourceProtocol
    
    init(remoteDataSource: FlickrFeedRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getFeed(_ searchString: String) async throws -> Result<Feed, FlickrError> {
        return try await remoteDataSource.getFeed(searchString)
    }
}
