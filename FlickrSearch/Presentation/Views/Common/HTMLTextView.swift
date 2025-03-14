//
//  HTMLTextView.swift
//  FlickrSearch
//
//  Created by Mikhail Kirsanov on 3/14/25.
//

import SwiftUI
import WebKit

struct HTMLTextView: UIViewRepresentable {
    let htmlString: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.dataDetectorTypes = .link
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        guard let data = htmlString.data(using: .utf8) else { return }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        if let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            uiView.attributedText = attributedString
        }
    }
}
