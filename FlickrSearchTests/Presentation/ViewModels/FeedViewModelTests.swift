//
//  FeedViewModelTests.swift
//  FlickrSearchTests
//
//  Created by Mikhail Kirsanov on 3/14/25.
//

import XCTest
import Combine
@testable import FlickrSearch

final class FeedViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    @MainActor
    func testGetFeed_Success() async {
        let mockItem = FeedItem(
            title: "title",
            author: "author",
            imageUrl: "imageUrl",
            tags: "tag tag",
            publishedDate: Date.now
        )
        let mockFeed = Feed(items: [mockItem])
        let mockGetFeedUseCase = MockGetFeedUseCase(result: .success(mockFeed))
        let viewModel = FeedViewModel(getFeedUseCase: mockGetFeedUseCase)
        
        await viewModel.getFeed("Test")
        
        XCTAssertEqual(viewModel.feed?.items.count, 1)
        XCTAssertEqual(viewModel.feed?.items[0].title, "title")
        XCTAssertEqual(viewModel.feed?.items[0].author, "author")
        XCTAssertEqual(viewModel.feed?.items[0].imageUrl, "imageUrl")
        XCTAssertEqual(viewModel.feed?.items[0].tags, "tag tag")
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }
}
