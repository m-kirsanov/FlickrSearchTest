//
//  ItemDetailsView.swift
//  FlickrSearch
//
//  Created by Mikhail Kirsanov on 3/14/25.
//

import SwiftUI
import WebKit

struct ItemDetailsView: View {
    let item: FeedItem
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                CachedAsyncImage(url: URL(string: item.imageUrl))
                
                if !item.title.isEmpty {
                    Text("Title:")
                        .font(.title2)
                    Text(item.title)
                        .font(.footnote)
                }
                if !item.author.isEmpty {
                    Text("Author:")
                        .font(.title2)
                    Text(item.author)
                        .font(.footnote)
                }
                
                Text("Published date:")
                    .font(.title2)
                Text(item.publishedDate.formatted())
                    .font(.footnote)
                
                if !item.tags.isEmpty {
                    Text("Tags:")
                        .font(.title2)
                    Text(item.tags)
                        .font(.footnote)
                }
            }
        }
        .navigationTitle("Item Details")
        .padding()
    }
}
