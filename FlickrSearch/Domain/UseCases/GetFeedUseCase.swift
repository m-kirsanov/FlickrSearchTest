//
//  GetFeedUseCase.swift
//  FlickrSearch
//
//  Created by Mikhail Kirsanov on 3/13/25.
//

import Foundation

protocol GetFeedUseCaseProtocol {
    func getFeed(_ searchString: String) async throws -> Result<Feed, FlickrError>
}

final class GetFeedUseCase: GetFeedUseCaseProtocol {
    private let repository: FlickrFeedRepositoryProtocol
    
    init(repository: FlickrFeedRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFeed(_ searchString: String) async throws -> Result<Feed, FlickrError> {
        return try await repository.getFeed(searchString)
    }
}
