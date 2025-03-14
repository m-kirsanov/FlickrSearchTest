//
//  MockGetFeedUseCase.swift
//  FlickrSearchTests
//
//  Created by Mikhail Kirsanov on 3/14/25.
//

@testable import FlickrSearch

class MockGetFeedUseCase: GetFeedUseCaseProtocol {
    enum MockResult {
        case success(Feed)
        case failure(Error)
    }
    
    var result: MockResult
    
    init(result: MockResult) {
        self.result = result
    }
    
    func getFeed(_ searchString: String) async throws -> Result<Feed, FlickrError> {
        switch result {
        case .success(let feed):
            return .success(feed)
        case .failure(_):
            return .failure(.internalError)
        }
    }
}
