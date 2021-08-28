//
//  FeedKitParser.swift
//  RssReader
//
//  Created by WF | Gordana Badarovska on 27.8.21.
//

import Foundation
import FeedKit
import RxSwift

class FeedKitParser: RSSParser {
    
    private var parser: FeedParser
    
    init(url: URL) {
        parser = FeedParser(URL: url)
    }
    
    deinit {
        parser.abortParsing()
    }
    
    func parse() -> Result<[RSSFeedItem], ParserError> {
        let result = parser.parse()
        switch result {
        case .success(let feed):
            guard let rssFeed = feed.rssFeed else {
                return .failure(ParserError.feedNotFound)
            }
            return .success(rssFeed.items ?? [])
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func parseAsync(callback: @escaping RSSParserCallback) {
        parser.parseAsync { result in
            switch result {
            case .success(let feed):
                guard let rssFeed = feed.rssFeed else {
                    let failure = Result<[RSSFeedItem], ParserError>.failure(ParserError.feedNotFound)
                    return callback(failure)
                }
                
                let feedItems = rssFeed.items ?? []
                let success = Result<[RSSFeedItem], ParserError>.success(feedItems)
                return callback(success)
            case .failure(let error):
                let failure = Result<[RSSFeedItem], ParserError>.failure(error)
                return callback(failure)
            }
        }
    }
    
    func parseAsync(queue: DispatchQueue, callback: @escaping RSSParserCallback) {
        parser.parseAsync(queue: queue) { result in
            switch result {
            case .success(let feed):
                guard let rssFeed = feed.rssFeed else {
                    let failure = Result<[RSSFeedItem], ParserError>.failure(ParserError.feedNotFound)
                    return callback(failure)
                }
                
                let feedItems = rssFeed.items ?? []
                let success = Result<[RSSFeedItem], ParserError>.success(feedItems)
                return callback(success)
            case .failure(let error):
                let failure = Result<[RSSFeedItem], ParserError>.failure(error)
                return callback(failure)
            }
        }
    }
    
    func abort() {
        parser.abortParsing()
    }
}
