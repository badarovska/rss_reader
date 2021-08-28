//
//  NewsFeedViewModel.swift
//  RssReader
//
//  Created by WF | Gordana Badarovska on 28.8.21.
//

import Foundation
import FeedKit
import RxCocoa

protocol NewsFeedViewModel {
    var error: Driver<Bool> { get }
    var isLoading: Driver<Bool> { get }
    var feed: Driver<[RSSFeedItem]> { get }
    
    func getFeed()
}
