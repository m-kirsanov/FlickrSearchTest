//
//  FlickrSearchView.swift
//  FlickrSearch
//
//  Created by Mikhail Kirsanov on 3/13/25.
//
import SwiftUI

struct FlickrSearchView: View {
    @StateObject private var viewModel: FeedViewModel
    
    init(viewModel: FeedViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ZStack {
                    Color(white: 0.0, opacity: 0.3)
                    ProgressView()
                }
            } else {
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 10),
                        GridItem(.flexible(), spacing: 10)
                    ]) {
                        ForEach(viewModel.feed?.items ?? []) { item in
                            NavigationLink(destination: ItemDetailsView(item: item)) {
                                VStack {
                                    CachedAsyncImage(url: URL(string: item.imageUrl))
                                }
                                .padding(10)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Feed")
        .searchable(text: $viewModel.searchText, prompt: "Search Flickr")
        .task {
            await viewModel.getFeed(viewModel.searchText)
        }
    }
}
