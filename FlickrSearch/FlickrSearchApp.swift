//
//  FlickrSearchApp.swift
//  FlickrSearch
//
//  Created by Mikhail Kirsanov on 3/13/25.
//

import SwiftUI

@main
struct FlickrSearchApp: App {
    var body: some Scene {
        let remoteDataSource = FlickrFeedRemoteDataSource()
        let repository = FlickrFeedRepository(remoteDataSource: remoteDataSource)
        let getFeedUseCase = GetFeedUseCase(repository: repository)
        let viewModel = FeedViewModel(getFeedUseCase: getFeedUseCase)
        
        WindowGroup {
            FlickrSearchView(viewModel: viewModel)
        }
    }
}
