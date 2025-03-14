//
//  CachedAsyncImage.swift
//  FlickrSearch
//
//  Created by Mikhail Kirsanov on 3/14/25.
//

import SwiftUI

class ImageCache {
    static let shared = ImageCache()
    private var cache = NSCache<NSURL, UIImage>()
    
    func get(url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }
    
    func set(url: URL, image: UIImage) {
        cache.setObject(image, forKey: url as NSURL)
    }
}

struct CachedAsyncImage: View {
    let url: URL?
    
    @State private var image: UIImage?
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
                    .task {
                        await loadImage()
                    }
            }
        }
    }
    
    private func loadImage() async {
        guard let url = url else { return }
        
        if let cachedImage = ImageCache.shared.get(url: url) {
            self.image = cachedImage
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let uiImage = UIImage(data: data) {
                self.image = uiImage
                ImageCache.shared.set(url: url, image: uiImage)
            }
        } catch {
            print("Failed to load image: \(error)")
        }
    }
}
