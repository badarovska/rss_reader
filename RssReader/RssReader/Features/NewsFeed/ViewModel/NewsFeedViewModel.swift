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
    var error: Driver<String> { get }
    var isLoading: Driver<Bool> { get }
    var feed: Driver<[RSSFeedItem]> { get }
    var title: Driver<String> { get }
    
    func getFeed()
    func getCategory()
}
