//
//  ErrorMessage.swift
//  RssReader
//
//  Created by WF | Gordana Badarovska on 29.8.21.
//

import Foundation

enum NewsFeedError: String {
    case genericError = """
        Whoops!
        An error happened!
    """
    
    case noFeedError = """
        Whoops!
        No news for this category!
    """
}
