//
//  FeedViewModel.swift
//  FlickrSearch
//
//  Created by Mikhail Kirsanov on 3/13/25.
//

import Foundation
import Combine

@MainActor
final class FeedViewModel: ObservableObject {
    @Published var feed: Feed? = nil
    @Published var searchText = "" {
        didSet { debounceSearch() }
    }
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let getFeedUseCase: GetFeedUseCaseProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    init(getFeedUseCase: GetFeedUseCaseProtocol) {
        self.getFeedUseCase = getFeedUseCase
    }
    
    func getFeed(_ searchString: String) async {
        isLoading = true
        do {
            let result = try await getFeedUseCase.getFeed(searchString)
            switch result {
            case .success(let feed):
                self.feed = feed
            case .failure(let error):
                errorMessage = error.localizedDescription
            }
        } catch {
            errorMessage = "Failed to load feed"
        }
        isLoading = false
    }
    
    private func debounceSearch() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] newText in
                Task {
                    await self?.getFeed(newText)
                }
            }
            .store(in: &cancellables)
    }
}
